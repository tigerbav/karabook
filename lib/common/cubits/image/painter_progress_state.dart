part of 'painter_progress_cubit.dart';

enum ImageStatus { initial, loading, done }

class PainterProgressState extends Equatable {
  final ImageStatus status;
  final PainterProgress? painterProgress;

  const PainterProgressState({
    this.status = ImageStatus.initial,
    this.painterProgress,
  });

  bool get isLoading => status == ImageStatus.loading;

  PainterProgressState copyWith({
    ImageStatus? status,
    PainterProgress? painterProgress,
  }) {
    return PainterProgressState(
      status: status ?? this.status,
      painterProgress: painterProgress ?? this.painterProgress,
    );
  }

  @override
  List<Object?> get props => [status, painterProgress];
}
