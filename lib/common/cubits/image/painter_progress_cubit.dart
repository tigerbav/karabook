import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';

part 'painter_progress_state.dart';

class PainterProgressCubit extends Cubit<PainterProgressState> {
  PainterProgressCubit(this.id) : super(const PainterProgressState()) {
    getProgress();
  }
  final int id;

  Future<void> getProgress() async {
    emit(state.copyWith(status: ImageStatus.loading));

    final painterProgress = await IsarService.shared.getObject(
      from: isar.painterProgress,
      id: id,
    );

    emit(PainterProgressState(
      status: ImageStatus.done,
      painterProgress: painterProgress,
    ));
  }
}
