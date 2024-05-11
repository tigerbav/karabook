part of 'game_cubit.dart';

enum GameStatus { initial, shapeTapped, exit, idle, completed }

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.initial,
    this.selectedShapes = const [],
    required this.allShapes,
    required this.painterProgress,
    required this.completedIds,
  });

  final GameStatus status;
  final List<SvgShapeModel> selectedShapes;
  final List<SvgShapeModel> allShapes;
  final PainterProgress painterProgress;
  final List<int> completedIds;

  bool get isCompleted => status == GameStatus.completed;

  GameState copyWith({
    GameStatus? status,
    List<SvgShapeModel>? selectedShapes,
    List<SvgShapeModel>? allShapes,
    PainterProgress? painterProgress,
    List<int>? completedIds,
  }) {
    return GameState(
      status: status ?? this.status,
      selectedShapes: selectedShapes ?? this.selectedShapes,
      allShapes: allShapes ?? this.allShapes,
      painterProgress: painterProgress ?? this.painterProgress,
      completedIds: completedIds ?? this.completedIds,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedShapes,
        allShapes,
        painterProgress,
        completedIds,
      ];
}
