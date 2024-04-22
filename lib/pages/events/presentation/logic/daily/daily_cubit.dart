import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/common/utils/extensions/string.dart';
import 'package:karabookapp/pages/events/domain/repositories/events_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'daily_state.dart';

class DailyCubit extends Cubit<DailyState> {
  DailyCubit(this._repository)
      : super(const DailyState(
          status: DailyStatus.initial,
          images: [],
        )) {
    _loadImages();
  }

  final IEventsRepository _repository;

  late final SharedPreferences _prefs;

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    final parsedTime = _prefs.getString(C.gift)?.time;
    if (parsedTime == null) return;

    //check days between current and last sessions
    if (DateTime.now().difference(parsedTime).inDays == 0) {
      emit(state.copyWith(status: DailyStatus.idle, isGotGift: true));
    }
  }

  Future<void> _loadImages() async {
    emit(state.copyWith(status: DailyStatus.loading));
    await _initSharedPreferences();

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
    _prefs.setString(C.gift, formatted);

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
}
