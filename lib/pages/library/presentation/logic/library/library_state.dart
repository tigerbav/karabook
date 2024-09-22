part of 'library_cubit.dart';

enum LibraryStatus {
  initial,
  idle,
  success,
  failure,
  loadingCategories,
  loadingImages,
  pagination
}

class LibraryState extends Equatable {
  const LibraryState({
    this.status = LibraryStatus.initial,
    this.errorMessage,
    this.currCategory,
    this.categories = const [],
    this.vipPacks = const [],
    this.mapImages = const {},
  });

  final LibraryStatus status;
  final String? errorMessage;
  final CategoryModel? currCategory;
  final List<CategoryModel> categories;
  final List<CategoryModel> vipPacks;
  final Map<int, List<ImageModel>> mapImages;

  bool get isLoadingCategories => status == LibraryStatus.loadingCategories;
  bool get isLoadingImages => status == LibraryStatus.loadingImages;
  bool get isPagination => status == LibraryStatus.pagination;
  bool get isFailure => status == LibraryStatus.failure;

  List<ImageModel> get imagesByCategory {
    if (currCategory == null) return [];

    return mapImages[currCategory!.id] ?? [];
  }

  LibraryState copyWith({
    required LibraryStatus status,
    String? errorMessage,
    CategoryModel? currCategory,
    List<CategoryModel>? categories,
    List<CategoryModel>? vipPacks,
    Map<int, List<ImageModel>>? mapImages,
    Map<int, int>? pages,
  }) {
    return LibraryState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      currCategory: currCategory ?? this.currCategory,
      categories: categories ?? this.categories,
      vipPacks: vipPacks ?? this.vipPacks,
      mapImages: mapImages ?? this.mapImages,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        currCategory,
        categories,
        vipPacks,
        mapImages,
      ];
}
