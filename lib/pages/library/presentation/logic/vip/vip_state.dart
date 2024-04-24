part of 'vip_cubit.dart';

enum VipStatus { initial, loading, success, failure }

class VipState extends Equatable {
  const VipState({
    this.status = VipStatus.initial,
    this.images = const [],
    this.messageError,
  });

  final VipStatus status;
  final List<SvgImage> images;
  final String? messageError;

  VipState copyWith({
    required VipStatus status,
    List<SvgImage>? images,
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
