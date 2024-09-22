import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/image_manager.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._repository) : super(const LibraryState()) {
    _loadCategories();
  }

  final LibraryRepository _repository;

  Future<void> _loadCategories() async {
    emit(state.copyWith(status: LibraryStatus.loadingCategories));

    final result = await _repository.getAllCategories();
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          status: LibraryStatus.success,
          categories: r,
          currCategory: r.firstOrNull,
        ));

        if (r.isEmpty) return;

        loadImages();
      },
    );
  }

  Future<void> loadImages() async {
    late final category = state.currCategory;

    if (state.isLoadingImages || category?.id == null) return;

    if (category!.id == C.vipID) {
      _loadPacks();
      return;
    }

    emit(state.copyWith(status: LibraryStatus.loadingImages));

    final categoryId = category.id;

    final result = await _repository.getImages(
      categoryId: categoryId,
      displayIds: state.mapImages[categoryId]?.map((e) => e.id).toList() ?? [],
    );
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        currCategory: category,
        errorMessage: l.errorMessage,
      )),
      (r) {
        if (r.isEmpty) {
          emit(state.copyWith(
            status: LibraryStatus.idle,
            currCategory: category,
          ));
        }

        final map = Map<int, List<ImageModel>>.from(state.mapImages);

        if (map[categoryId] == null) {
          map[categoryId] = r;
        } else {
          map[categoryId]!.addAll(r);
        }

        emit(state.copyWith(
          status: LibraryStatus.idle,
          mapImages: map,
          currCategory: category,
        ));
      },
    );
  }

  Future<void> getImages() async {
    if (state.isPagination) return;

    final categoryId = state.currCategory?.id;
    if (categoryId == null) return;

    emit(state.copyWith(status: LibraryStatus.pagination));

    final result = await _repository.getImages(
      categoryId: categoryId,
      displayIds: state.mapImages[categoryId]?.map((e) => e.id).toList() ?? [],
    );
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        final map = Map<int, List<ImageModel>>.from(state.mapImages);

        if (map[categoryId] == null) {
          map[categoryId] = r;
        } else {
          map[categoryId]!.addAll(r);
        }

        emit(state.copyWith(
          status: LibraryStatus.idle,
          mapImages: map,
        ));
      },
    );
  }

  Future<void> updImage(ImageModel oldImage) async {
    final newImage = await ImageManager.shared.getImageById(oldImage.id);
    if (oldImage.completedIds == newImage?.completedIds || newImage == null) {
      return;
    }

    final map = Map<int, List<ImageModel>>.from(state.mapImages);
    final list = map[newImage.categoryId]
        ?.map((e) => e.id == newImage.id ? newImage : e)
        .toList();

    if (list == null || newImage.categoryId == null) return;
    map[newImage.categoryId!] = list;

    emit(state.copyWith(status: LibraryStatus.idle, mapImages: map));
  }

  Future<void> _loadPacks() async {
    if (state.vipPacks.isNotEmpty) return;

    emit(state.copyWith(status: LibraryStatus.loadingImages));
    final result = await _repository.getVipCategories();
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          status: LibraryStatus.success,
          vipPacks: r,
        ));
      },
    );
  }

  void setCurrentCategory(int id) {
    final currCategory = state.categories.firstWhereOrNull((e) => e.id == id);
    if (state.currCategory == currCategory) return;

    emit(state.copyWith(
      status: LibraryStatus.idle,
      currCategory: currCategory,
    ));

    if (state.imagesByCategory.isEmpty) loadImages();
  }
}
