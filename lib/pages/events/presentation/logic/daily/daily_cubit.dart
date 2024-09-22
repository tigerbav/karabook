import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/pages/events/domain/repositories/events_repository.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/image_manager.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'daily_state.dart';

class DailyCubit extends Cubit<DailyState> {
  DailyCubit(this._repository) : super(const DailyState(images: [])) {
    _loadImages();
  }

  final IEventsRepository _repository;

  // TODO: future implementation
  // Future<void> _checkCurrentDaily() async {
  //   final timeStr = await SharedPrefManager.shared.get(C.gift);
  //   if (timeStr is! String) return;
  //
  //   final parsedTime = timeStr.time;
  //   if (parsedTime == null) return;
  //
  //   //check days between current and last sessions
  //   if (DateTime.now().difference(parsedTime).inDays == 0) {
  //     emit(state.copyWith(status: DailyStatus.idle, isGotGift: true));
  //   }
  // }

  Future<void> _loadImages() async {
    emit(state.copyWith(status: DailyStatus.loading));
    // await _checkCurrentDaily();

    final result = await _repository.getDailyImages();
    result.fold(
      (l) => emit(state.copyWith(
        status: DailyStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(
        status: DailyStatus.success,
        images: r,
      )),
    );
  }

  bool decreaseOpacity() {
    if (state.isGotGift == true) return true;
    final formatted = DateFormat('yyyy-MM-dd').format(DateTime.now());
    SharedPrefManager.shared.write(C.gift, formatted);

    emit(state.copyWith(status: DailyStatus.idle, opacity: 0));
    return false;
  }

  void increaseOpacity() {
    emit(state.copyWith(
      status: DailyStatus.idle,
      opacity: 1,
      isGotGift: true,
    ));
  }

  Future<void> updImage(ImageModel oldImage) async {
    final newImage = await ImageManager.shared.getImageById(oldImage.id);
    if (oldImage.completedIds == newImage?.completedIds || newImage == null) {
      return;
    }

    var list = List<ImageModel>.from(state.images);
    list = list.map((e) => e.id == newImage.id ? newImage : e).toList();

    emit(state.copyWith(status: DailyStatus.idle, images: list));
  }
}
