part of 'daily_cubit.dart';

enum DailyStatus { initial, loading, failure, success, idle }

class DailyState extends Equatable {
  const DailyState({
    this.status = DailyStatus.initial,
    this.errorMessage,
    this.opacity = 1.0,
    this.isGotGift = true,
    required List<ImageModel> images,
  }) : _images = images;

  List<ImageModel> get images => _images;

  bool get isLoading => status == DailyStatus.loading;
  bool get isFailure => status == DailyStatus.failure;

  final DailyStatus status;
  final String? errorMessage;
  final double opacity;
  final bool isGotGift;
  final List<ImageModel> _images;

  DailyState copyWith({
    required DailyStatus status,
    String? errorMessage,
    double? opacity,
    bool? isGotGift,
    List<ImageModel>? images,
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
