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
    _loadCategories();
    _loadImages();
  }

  final LibraryRepository _repository;

  Future<void> _loadCategories() async {
    emit(state.copyWith(status: LibraryStatus.loading));
    final result = await _repository.getAllCategories();
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(
        status: LibraryStatus.success,
        categories: r,
        currCategory: r.firstOrNull,
      )),
    );
  }

  Future<void> _loadImages() async {
    emit(state.copyWith(status: LibraryStatus.loading));
    final result = await _repository.getAllImages();
    result.fold(
      (l) => emit(state.copyWith(
        status: LibraryStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(
        status: LibraryStatus.success,
        images: r,
      )),
    );
  }

  void setCurrentCategory(int id) {
    emit(state.copyWith(
      status: LibraryStatus.idle,
      currCategory: state._categories.firstWhereOrNull((e) => e.id == id),
    ));
  }
}
