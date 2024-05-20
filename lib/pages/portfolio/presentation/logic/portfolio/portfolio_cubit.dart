import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:karabookapp/pages/portfolio/presentation/enums/status_type.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit(this._repository)
      : super(const PortfolioState(
          status: PortfolioStatus.initial,
          completedImages: [],
          progressImages: [],
        )) {
    _loadImages();
  }

  final IPortfolioRepository _repository;

  Future<void> _loadImages() async {
    await _loadCurrImages();
    await _loadCompletedImages();
  }

  Future<void> _loadCurrImages() async {
    emit(state.copyWith(status: PortfolioStatus.loading));
    final result = await _repository.getCurrentImages();
    result.fold(
      (l) => emit(state.copyWith(
        status: PortfolioStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(
        status: PortfolioStatus.success,
        progressImages: r,
      )),
    );
  }

  Future<void> _loadCompletedImages() async {
    emit(state.copyWith(status: PortfolioStatus.loading));
    final result = await _repository.getCompletedImages();
    result.fold(
      (l) => emit(state.copyWith(
        status: PortfolioStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(
        status: PortfolioStatus.success,
        completedImages: r,
      )),
    );
  }

  void setStatusType(StatusType statusType) {
    emit(state.copyWith(
      status: PortfolioStatus.idle,
      statusType: statusType,
    ));
  }
}
