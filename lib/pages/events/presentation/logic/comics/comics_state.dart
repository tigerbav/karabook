part of 'comics_cubit.dart';

enum ComicsStatus { initial, loading, pagination, failure, success, idle }

class ComicsState extends Equatable {
  const ComicsState({
    this.status = ComicsStatus.initial,
    this.errorMessage,
    this.packs = const {},
    this.completeMap = const {},
  });

  final ComicsStatus status;
  final String? errorMessage;
  final Map<CategoryModel, List<ImageModel>> packs;
  final Map<CategoryModel, int> completeMap;

  bool get isLoading => status == ComicsStatus.loading;
  bool get isPagination => status == ComicsStatus.pagination;
  bool get isFailure => status == ComicsStatus.failure;

  ComicsState copyWith({
    required ComicsStatus status,
    String? errorMessage,
    Map<CategoryModel, List<ImageModel>>? packs,
    Map<CategoryModel, int>? completeMap,
  }) {
    return ComicsState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      packs: packs ?? this.packs,
      completeMap: completeMap ?? this.completeMap,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, packs, completeMap];
}
