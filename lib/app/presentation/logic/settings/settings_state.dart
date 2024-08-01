part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isVibration = false,
    this.isAnimation = false,
    this.isAds = true,
    this.email,
  });

  final bool isVibration;
  final bool isAnimation;
  final bool isAds;
  final String? email;

  bool get hasEmail => email != null;

  bool? valueByOptionType(SettingsType type) {
    switch (type) {
      case SettingsType.vibration:
        return isVibration;
      case SettingsType.fill:
        return isAnimation;
      default:
        return null;
    }
  }

  SettingsState copyWith({
    bool? isVibration,
    bool? isAnimation,
    bool? isAds,
    String? email,
  }) {
    return SettingsState(
      isVibration: isVibration ?? this.isVibration,
      isAnimation: isAnimation ?? this.isAnimation,
      isAds: isAds ?? this.isAds,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [isVibration, isAnimation, isAds, email];
}
