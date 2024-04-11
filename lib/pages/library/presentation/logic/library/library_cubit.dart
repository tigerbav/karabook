import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._repository)
      : super(const LibraryState(
          status: LibraryStatus.initial,
          currCategory: null,
          categories: [],
          images: [],
        )) {
    refresh(isRefresh: false);
  }

  final LibraryRepository _repository;

  Future<void> _loadCategories([bool isRefresh = false]) async {
    if (isRefresh == false) {
      emit(state.copyWith(status: LibraryStatus.loadingCategories));
    }

    final result = await _repository.getAllCategories();
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        if (r.length == state._categories.length) return;

        emit(state.copyWith(
          status: LibraryStatus.success,
          categories: r,
        ));
      },
    );
  }

  Future<void> _loadImages([bool isRefresh = false]) async {
    if (isRefresh == false) {
      emit(state.copyWith(status: LibraryStatus.loadingImages));
    }

    final result = await _repository.getAllImages();
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        if (r.length == state._images.length) return;

        emit(state.copyWith(
          status: LibraryStatus.success,
          images: r,
          currCategory: state.categoriesWithImages(r).firstOrNull,
        ));
      },
    );
  }

  Future<void> refresh({required bool isRefresh}) async {
    _loadCategories(isRefresh);
    _loadImages(isRefresh);
  }

  void setCurrentCategory(int id) {
    emit(state.copyWith(
      status: LibraryStatus.idle,
      currCategory: state._categories.firstWhereOrNull((e) => e.id == id),
    ));
  }
}
