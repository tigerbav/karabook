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
    required this.status,
    this.errorMessage,
    required this.currCategory,
    required this.categories,
    required this.images,
    // required this.packs,
  });

  final LibraryStatus status;
  final String? errorMessage;
  final ImageCategory? currCategory;
  final List<ImageCategory> categories;
  final List<SvgImage> images;
  // final List<Pack> packs;

  bool get isLoadingCategories => status == LibraryStatus.loadingCategories;
  bool get isLoadingImages => status == LibraryStatus.loadingImages;
  bool get isFailure => status == LibraryStatus.failure;

  List<SvgImage>? get imagesByCategory {
    if (currCategory == null) return null;

    return images.where((e) => e.categoryId == currCategory?.id).toList();
  }

  List<ImageCategory> categoriesWithImages([List<SvgImage>? images]) {
    final filteredCategories = <ImageCategory>[];

    for (final category in categories) {
      final image = images?.firstWhereOrNull(
        (e) => e.categoryId == category.id,
      );

      if (image != null) filteredCategories.add(category);
    }
    // if (filteredCategories.firstWhereOrNull((e) => e.name == C.vip) == null) {
    //   filteredCategories.add(const ImageCategory(id: -1, name: C.vip));
    // }

    return filteredCategories;
  }

  LibraryState copyWith({
    required LibraryStatus status,
    String? errorMessage,
    ImageCategory? currCategory,
    List<ImageCategory>? categories,
    List<SvgImage>? images,
    // List<Pack>? packs,
  }) {
    return LibraryState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      currCategory: currCategory ?? this.currCategory,
      categories: categories ?? this.categories,
      images: images ?? this.images,
      // packs: packs ?? this.packs,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        currCategory,
        categories,
        images,
        // packs,
      ];
}
