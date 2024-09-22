part of 'banner_cubit.dart';

enum BannerStatus { init, loading, failure, success, idle, tick }

class BannerState extends Equatable {
  const BannerState({
    this.status = BannerStatus.init,
    this.categories = const [],
    this.page = 0,
    this.errorMessage,
  });

  final BannerStatus status;
  final List<CategoryModel> categories;
  final int page;
  final String? errorMessage;

  bool get isLoading => status == BannerStatus.loading;
  bool get isTick => status == BannerStatus.tick;

  BannerState copyWith({
    required BannerStatus status,
    List<CategoryModel>? categories,
    int? page,
    String? errorMessage,
  }) {
    return BannerState(
      status: status,
      categories: categories ?? this.categories,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, page, errorMessage];
}
