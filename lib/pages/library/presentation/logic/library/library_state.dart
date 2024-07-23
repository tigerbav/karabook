part of 'library_cubit.dart';

enum LibraryStatus {
  initial,
  idle,
  success,
  failure,
  loadingCategories,
  loadingImages,
}

class LibraryState extends Equatable {
  const LibraryState({
    this.status = LibraryStatus.initial,
    this.errorMessage,
    this.currCategory,
    this.categories = const [],
    this.vipPacks = const [],
    this.mapImages = const {},
    this.pages = const {},
  });

  final LibraryStatus status;
  final String? errorMessage;
  final CategoryModel? currCategory;
  final List<CategoryModel> categories;
  final List<CategoryModel> vipPacks;
  final Map<int, List<ImageModel>> mapImages;

  /// {key: categoryId, value: lastPage}
  final Map<int, int> pages;

  bool get isLoadingCategories => status == LibraryStatus.loadingCategories;
  bool get isLoadingImages => status == LibraryStatus.loadingImages;
  bool get isFailure => status == LibraryStatus.failure;

  int? get currPage {
    if (currCategory == null || mapImages[currCategory?.id] == null) {
      return null;
    }

    return mapImages[currCategory!.id]!.length ~/ C.imageOnPage;
  }

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
      pages: pages ?? this.pages,
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
        pages,
      ];
}
