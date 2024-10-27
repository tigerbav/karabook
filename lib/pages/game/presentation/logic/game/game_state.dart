part of 'game_cubit.dart';

enum GameStatus {
  init,
  loading,
  success,
  failure,
  idle,
  completeInit,
  completed,
  exit,
  save,
}

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.init,
    required this.imageModel,
    this.sortedShapes = const {},
    this.svgLines = const [],
    this.selectedShapes = const [],
    this.zoomScale = 1,
    this.isCompleted = false,
    this.errorMessage,
  });

  final GameStatus status;
  final ImageModel imageModel;
  final Map<Color, List<SvgShapeModel>> sortedShapes;
  final List<SvgLineModel> svgLines;
  final List<SvgShapeModel> selectedShapes;
  final int zoomScale;
  final bool isCompleted;
  final String? errorMessage;

  bool get isSaving => status == GameStatus.save;
  bool get isLoading => status == GameStatus.loading;
  bool get isCompleteInit => status == GameStatus.completeInit;

  List<SvgShapeModel> get allShapes =>
      sortedShapes.values.expand((l) => l).toList();

  List<SvgShapeModel> get painted {
    final completedIds = imageModel.completedIds;
    if (completedIds == null) return [];

    final unsortedList =
        selectedShapes.where((e) => e.isPainted == true).toList();
    final sortedList = <SvgShapeModel>[];

    for (final id in completedIds) {
      final item = unsortedList.firstWhereOrNull((e) => e.id == id);
      if (item != null) sortedList.add(item);
    }
    return sortedList;
  }

  List<SvgShapeModel> get unPainted {
    final list = <SvgShapeModel>[];
    for (final shape in allShapes) {
      if (imageModel.completedIds?.contains(shape.id) == false) list.add(shape);
    }

    return list;
  }

  GameState copyWith({
    required GameStatus status,
    ImageModel? imageModel,
    Map<Color, List<SvgShapeModel>>? sortedShapes,
    List<SvgLineModel>? svgLines,
    List<SvgShapeModel>? selectedShapes,
    int? zoomScale,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return GameState(
      status: status,
      imageModel: imageModel ?? this.imageModel,
      sortedShapes: sortedShapes ?? this.sortedShapes,
      svgLines: svgLines ?? this.svgLines,
      selectedShapes: selectedShapes ?? this.selectedShapes,
      zoomScale: zoomScale ?? this.zoomScale,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        imageModel,
        errorMessage,
        sortedShapes,
        svgLines,
        selectedShapes,
        isCompleted,
        zoomScale,
      ];
}
