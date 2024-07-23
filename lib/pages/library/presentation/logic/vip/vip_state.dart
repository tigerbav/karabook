part of 'vip_cubit.dart';

enum VipStatus { initial, loading, success, failure }

class VipState extends Equatable {
  const VipState({
    this.status = VipStatus.initial,
    this.images = const [],
    this.messageError,
  });

  final VipStatus status;
  final List<ImageModel> images;
  final String? messageError;

  bool get isLoading => status == VipStatus.loading;

  VipState copyWith({
    required VipStatus status,
    List<ImageModel>? images,
    String? messageError,
  }) {
    return VipState(
      status: status,
      images: images ?? this.images,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [status, images, messageError];
}
