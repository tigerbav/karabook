part of 'library_cubit.dart';

enum LibraryStatus { initial, idle, success, failure, loading }

class LibraryState extends Equatable {
  const LibraryState({
    required this.status,
    this.errorMessage,
    required this.currCategory,
    required List<ImageCategory> categories,
    required List<SvgImage> images,
  })  : _categories = categories,
        _images = images;

  final LibraryStatus status;
  final String? errorMessage;
  final ImageCategory? currCategory;
  final List<ImageCategory> _categories;
  final List<SvgImage> _images;

  List<ImageCategory> get categories => _categories;
  List<SvgImage> get images => _images;

  bool get isLoading => status == LibraryStatus.loading;
  bool get isFailure => status == LibraryStatus.failure;

  LibraryState copyWith({
    required LibraryStatus status,
    String? errorMessage,
    ImageCategory? currCategory,
    List<ImageCategory>? categories,
    List<SvgImage>? images,
  }) {
    return LibraryState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      currCategory: currCategory ?? this.currCategory,
      categories: categories ?? _categories,
      images: images ?? _images,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        currCategory,
        _categories,
        _images,
      ];
}
