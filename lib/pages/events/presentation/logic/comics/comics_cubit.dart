import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/pages/events/domain/repositories/events_repository.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';

part 'comics_state.dart';

class ComicsCubit extends Cubit<ComicsState> {
  ComicsCubit(this._repository) : super(const ComicsState()) {
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
        packs: r,
        completeMap: r.map((key, value) => MapEntry(key, 0)),
      )),
    );

    final query =
        isar.painterProgress.filter().isCompletedEqualTo(true).build();
    final stream = query.watch(fireImmediately: true);

    stream.listen((event) {
      final completedIds = event.map((e) => e.id).toList();
      final updatedMap = state.completeMap.map((key, value) {
        final list = state.packs[key];
        if (list == null) return MapEntry(key, value);
        var completeIndex = 0;
        for (var i = 0; i < list.length; i++) {
          if (completedIds.contains(list[i].id)) {
            completeIndex++;
            continue;
          }
          break;
        }
        return MapEntry(key, completeIndex);
      });

      emit(state.copyWith(
        status: ComicsStatus.idle,
        completeMap: updatedMap,
      ));
    });
  }
}
