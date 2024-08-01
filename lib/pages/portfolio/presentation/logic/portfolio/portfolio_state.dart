part of 'portfolio_cubit.dart';

enum PortfolioStatus { initial, idle, success, failure, loading }

class PortfolioState extends Equatable {
  const PortfolioState({
    required this.status,
    this.errorMessage,
    this.statusType = StatusType.inProgress,
    this.completedLength = 0,
    required List<ImageModel> completedImages,
    required List<ImageModel> progressImages,
  })  : _completedImages = completedImages,
        _progressImages = progressImages;

  final PortfolioStatus status;
  final String? errorMessage;
  final StatusType statusType;
  final int completedLength;
  final List<ImageModel> _completedImages;
  final List<ImageModel> _progressImages;

  List<ImageModel> get completedImages => _completedImages;
  List<ImageModel> get progressImages => _progressImages;

  bool get isLoading => status == PortfolioStatus.loading;

  PortfolioState copyWith({
    required PortfolioStatus status,
    String? errorMessage,
    StatusType? statusType,
    int? completedLength,
    List<ImageModel>? completedImages,
    List<ImageModel>? progressImages,
  }) {
    return PortfolioState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusType: statusType ?? this.statusType,
      completedLength: completedLength ?? this.completedLength,
      completedImages: completedImages ?? _completedImages,
      progressImages: progressImages ?? _progressImages,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        statusType,
        completedLength,
        _completedImages,
        _progressImages,
      ];
}
