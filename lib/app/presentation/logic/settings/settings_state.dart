part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isVibration = false,
    this.isAnimation = false,
    this.isAds = true,
    this.email,
    this.userId,
  });

  final bool isVibration;
  final bool isAnimation;
  final bool isAds;
  final String? email;
  final int? userId;

  bool get hasEmail => email != null;

  bool? valueByOptionType(SettingsType type) {
    switch (type) {
      case SettingsType.vibration:
        return isVibration;
      // case SettingsType.fill:
      //   return isAnimation;
      default:
        return null;
    }
  }

  SettingsState copyWith({
    bool? isVibration,
    bool? isAnimation,
    bool? isAds,
    String? email,
    int? userId,
  }) {
    return SettingsState(
      isVibration: isVibration ?? this.isVibration,
      isAnimation: isAnimation ?? this.isAnimation,
      isAds: isAds ?? this.isAds,
      email: email ?? this.email,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        isVibration,
        isAnimation,
        isAds,
        email,
        userId,
      ];
}
