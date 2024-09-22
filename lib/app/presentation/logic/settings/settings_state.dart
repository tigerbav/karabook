part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isVibration = false,
    this.isAnimation = false,
    this.isFillHint = false,
    this.isAds = true,
    this.email,
    this.userId,
  });

  final bool isVibration;
  final bool isAnimation;
  final bool isFillHint;
  final bool isAds;
  final String? email;
  final int? userId;

  bool get hasEmail => email != null;

  bool? valueByOptionType(SettingsType type) {
    switch (type) {
      case SettingsType.vibration:
        return isVibration;
      case SettingsType.fill:
        return isAnimation;
      case SettingsType.autoFill:
        return isFillHint;
      default:
        return null;
    }
  }

  SettingsState copyWith({
    bool? isVibration,
    bool? isAnimation,
    bool? isFillHint,
    bool? isAds,
    String? email,
    int? userId,
  }) {
    return SettingsState(
      isVibration: isVibration ?? this.isVibration,
      isAnimation: isAnimation ?? this.isAnimation,
      isFillHint: isFillHint ?? this.isFillHint,
      isAds: isAds ?? this.isAds,
      email: email ?? this.email,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        isVibration,
        isAnimation,
        isFillHint,
        isAds,
        email,
        userId,
      ];
}
