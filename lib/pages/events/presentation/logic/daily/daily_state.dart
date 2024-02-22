part of 'daily_cubit.dart';

enum DailyStatus { initial, loading, failure, success, idle }

class DailyState extends Equatable {
  const DailyState({
    required this.status,
    this.errorMessage,
    this.opacity = 1.0,
    this.isGotGift = false,
    required List<SvgImage> images,
  }) : _images = images;

  List<SvgImage> get images => _images;

  bool get isLoading => status == DailyStatus.loading;
  bool get isFailure => status == DailyStatus.failure;

  final DailyStatus status;
  final String? errorMessage;
  final double opacity;
  final bool isGotGift;
  final List<SvgImage> _images;

  DailyState copyWith({
    required DailyStatus status,
    String? errorMessage,
    double? opacity,
    bool? isGotGift,
    List<SvgImage>? images,
  }) {
    return DailyState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      opacity: opacity ?? this.opacity,
      isGotGift: isGotGift ?? this.isGotGift,
      images: images ?? _images,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        opacity,
        isGotGift,
        _images,
      ];
}
