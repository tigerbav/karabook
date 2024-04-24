part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isVibration = false,
    this.isAnimation = false,
    this.isAds = false,
  });

  final bool isVibration;
  final bool isAnimation;
  final bool isAds;

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
  }) {
    return SettingsState(
      isVibration: isVibration ?? this.isVibration,
      isAnimation: isAnimation ?? this.isAnimation,
      isAds: isAds ?? this.isAds,
    );
  }

  @override
  List<Object?> get props => [isVibration, isAnimation, isAds];
}
