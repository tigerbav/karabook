part of 'portfolio_cubit.dart';

enum PortfolioStatus { initial, idle, success, failure, loading }

class PortfolioState extends Equatable {
  const PortfolioState({
    required this.status,
    this.errorMessage,
    this.statusType = StatusType.inProgress,
    required List<SvgImage> completedImages,
    required List<SvgImage> progressImages,
  })  : _completedImages = completedImages,
        _progressImages = progressImages;

  final PortfolioStatus status;
  final String? errorMessage;
  final StatusType statusType;
  final List<SvgImage> _completedImages;
  final List<SvgImage> _progressImages;

  List<SvgImage> get completedImages => _completedImages;
  List<SvgImage> get progressImages => _progressImages;

  bool get isLoading => status == PortfolioStatus.loading;

  PortfolioState copyWith({
    required PortfolioStatus status,
    String? errorMessage,
    StatusType? statusType,
    List<SvgImage>? completedImages,
    List<SvgImage>? progressImages,
  }) {
    return PortfolioState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusType: statusType ?? this.statusType,
      completedImages: completedImages ?? _completedImages,
      progressImages: progressImages ?? _progressImages,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        statusType,
        _completedImages,
        _progressImages,
      ];
}
