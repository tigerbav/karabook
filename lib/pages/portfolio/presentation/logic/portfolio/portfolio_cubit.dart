import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:karabookapp/pages/portfolio/presentation/enums/status_type.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit(this._repository)
      : super(const PortfolioState(
          status: PortfolioStatus.initial,
          completedImages: [],
          progressImages: [],
        )) {
    loadImages();
  }

  final IPortfolioRepository _repository;
  StreamSubscription? _currentImages;
  StreamSubscription? _completedImages;

  Future<void> loadImages() async {
    final context = App.navigatorKey.currentContext;
    if (context == null) return;

    _loadCurrImages(context);
    _loadCompletedImages(context);
  }

  void _loadCurrImages(BuildContext context) {
    emit(state.copyWith(status: PortfolioStatus.loading));

    final stream = _repository.getCurrentImages();
    if (stream == null) {
      emit(state.copyWith(
        status: PortfolioStatus.failure,
        errorMessage: LocaleKeys.something_went_wrong.tr(),
      ));
      return;
    }

    _currentImages?.cancel();
    _currentImages = stream.listen((data) {
      emit(state.copyWith(
        status: PortfolioStatus.success,
        progressImages: data,
      ));
    });
  }

  void _loadCompletedImages(BuildContext context) {
    emit(state.copyWith(status: PortfolioStatus.loading));

    final stream = _repository.getCompletedImages();
    if (stream == null) {
      emit(state.copyWith(
        status: PortfolioStatus.failure,
        errorMessage: LocaleKeys.something_went_wrong.tr(),
      ));
      return;
    }

    _completedImages?.cancel();
    _completedImages = stream.listen((data) {
      emit(state.copyWith(
        status: PortfolioStatus.success,
        completedImages: data,
      ));
    });
  }

  void setStatusType(StatusType statusType) {
    emit(state.copyWith(
      status: PortfolioStatus.idle,
      statusType: statusType,
    ));
  }

  @override
  Future<void> close() {
    _currentImages?.cancel();
    _completedImages?.cancel();
    return super.close();
  }
}
