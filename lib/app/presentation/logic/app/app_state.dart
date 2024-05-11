part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  AppState setLifecycle(
    AppLifecycleState lifecycleState,
  );
}

class AppSplash extends AppState {
  AppSplash({this.isLoading = false});
  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];

  @override
  AppState setLifecycle(
    AppLifecycleState lifecycleState,
  ) =>
      this;
}

class AppMenu extends AppState {
  AppMenu({required this.lifecycleState});

  final AppLifecycleState lifecycleState;

  @override
  AppMenu setLifecycle(AppLifecycleState? lifecycleState) {
    return AppMenu(
      lifecycleState: lifecycleState ?? this.lifecycleState,
    );
  }

  @override
  List<Object?> get props => [lifecycleState];
}
