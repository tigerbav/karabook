import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/enums/tab_bar_type.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/screens/tab_bar_screen.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/navigation/app_router.dart';
part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit(this._repository) : super(const BannerState()) {
    _init();
  }

  final ILibraryRepository _repository;

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
  }

  void setPage(int page, {bool isTimer = false}) {
    if (isTimer) return;

    emit(state.copyWith(
      status: BannerStatus.idle,
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
}
