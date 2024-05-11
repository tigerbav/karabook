part of 'loading_game_cubit.dart';

enum LoadingGameStatus { initial, failure, success, loading }

class LoadingGameState extends Equatable {
  const LoadingGameState({
    this.status = LoadingGameStatus.initial,
    this.errorMessage,
  });

  final LoadingGameStatus status;
  final String? errorMessage;

  bool get isFailure => status == LoadingGameStatus.failure;

  @override
  List<Object?> get props => [status, errorMessage];
}
