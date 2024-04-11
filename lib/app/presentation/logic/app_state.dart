part of 'app_cubit.dart';

abstract class AppState extends Equatable {}

class AppSplash extends AppState {
  AppSplash({this.isLoading = false});
  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}

class AppMenu extends AppState {
  @override
  List<Object?> get props => [];
}

class AppGame extends AppState {
  @override
  List<Object?> get props => [];
}
