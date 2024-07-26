part of 'vip_cubit.dart';

enum VipStatus { initial, loading, success, failure, idle }

class VipState extends Equatable {
  const VipState({
    this.status = VipStatus.initial,
    this.images = const [],
    this.messageError,
    this.offering,
    this.isAvailable = false,
    this.progressStep = 0,
  });

  final VipStatus status;
  final List<ImageModel> images;
  final String? messageError;
  final Offering? offering;
  final bool isAvailable;
  final int progressStep;

  bool get isLoading => status == VipStatus.loading;

  List<ImageModel?> get visibleImages {
    return List.generate(
      images.length,
      (index) => index <= progressStep && isAvailable ? images[index] : null,
    );
  }

  VipState copyWith({
    required VipStatus status,
    List<ImageModel>? images,
    String? messageError,
    Offering? offering,
    bool? isAvailable,
    int? progressStep,
  }) {
    return VipState(
      status: status,
      images: images ?? this.images,
      messageError: messageError ?? this.messageError,
      offering: offering ?? this.offering,
      isAvailable: isAvailable ?? this.isAvailable,
      progressStep: progressStep ?? this.progressStep,
    );
  }

  @override
  List<Object?> get props => [
        status,
        images,
        messageError,
        offering,
        isAvailable,
        progressStep,
      ];
}
