import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/enums/tab_bar_type.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/navigation/app_router.dart';
part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit(this._repository) : super(const BannerState()) {
    _init();
  }

  final ILibraryRepository _repository;
  Timer? _timer;

  Future<void> _init() async {
    emit(state.copyWith(status: BannerStatus.loading));

    final result = await _repository.getBanners();
    result.fold(
      (l) => emit(state.copyWith(
        status: BannerStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          status: BannerStatus.success,
          categories: r,
        ));
      },
    );

    _initTimer();
  }

  _initTimer() {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: C.bannerSecTick),
      () {
        setPage((state.page + 1) % state.categories.length, isTimer: true);
      },
    );
  }

  void setPage(int page, {bool isTimer = false}) {
    _initTimer();

    emit(state.copyWith(
      status: isTimer ? BannerStatus.tick : BannerStatus.idle,
      page: page,
    ));
  }

  void onTap(CategoryModel category, BuildContext context) {
    final isFree = category.categoryTypeId == C.packTypeId;
    if (isFree) {
      context.tabsRouter.setActiveIndex(TabBarType.events.index);
    } else {
      context.pushRoute(VipRoute(pack: category));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
