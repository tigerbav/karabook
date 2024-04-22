import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/events/domain/repositories/events_repository.dart';

part 'comics_state.dart';

class ComicsCubit extends Cubit<ComicsState> {
  ComicsCubit(this._repository)
      : super(const ComicsState(
          status: ComicsStatus.initial,
          images: [],
        )) {
    _loadImages();
  }

  final IEventsRepository _repository;

  Future<void> _loadImages() async {
    emit(state.copyWith(status: ComicsStatus.loading));

    final result = await _repository.getComics();
    result.fold(
      (l) => emit(state.copyWith(
        status: ComicsStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(
        status: ComicsStatus.success,
        images: r,
      )),
    );
  }
}
