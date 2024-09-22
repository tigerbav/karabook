import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/events/domain/repositories/events_repository.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/image_manager.dart';

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

    final query = isar.imageModels.filter().isCompletedEqualTo(true).build();
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

  Future<void> loadImages(CategoryModel category) async {
    emit(state.copyWith(status: ComicsStatus.pagination));

    final result = await _repository.getComicsList(
      categoryId: category.id,
      displayIds: state.packs[category]?.map((e) => e.id).toList() ?? [],
    );
    result.fold(
      (l) => emit(state.copyWith(
        status: ComicsStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        final map = Map<CategoryModel, List<ImageModel>>.from(state.packs);
        map[category]?.addAll(r);
        emit(state.copyWith(
          status: ComicsStatus.success,
          packs: map,
        ));
      },
    );
  }

  Future<void> updImage(ImageModel oldImage) async {
    final newImage = await ImageManager.shared.getImageById(oldImage.id);
    if (oldImage.completedIds == newImage?.completedIds || newImage == null) {
      return;
    }

    final map = Map<CategoryModel, List<ImageModel>>.from(state.packs);
    final category =
        map.keys.firstWhereOrNull((e) => e.id == newImage.categoryId);
    if (category == null) return;

    final list =
        map[category]?.map((e) => e.id == newImage.id ? newImage : e).toList();

    if (list == null) return;
    map[category] = list;

    emit(state.copyWith(status: ComicsStatus.idle, packs: map));
  }
}
