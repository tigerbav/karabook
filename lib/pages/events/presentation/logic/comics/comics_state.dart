part of 'comics_cubit.dart';

enum ComicsStatus { initial, loading, failure, success, idle }

class ComicsState extends Equatable {
  const ComicsState({
    required this.status,
    this.errorMessage,
    required List<SvgImage> images,
  }) : _images = images;

  final ComicsStatus status;
  final String? errorMessage;
  final List<SvgImage> _images;

  bool get isLoading => status == ComicsStatus.loading;
  bool get isFailure => status == ComicsStatus.failure;

  List<SvgImage> get images => _images;

  List<List<SvgImage>> get comicsPack {
    final map = <String, List<SvgImage>>{};
    for (final image in _images) {
      final key = image.subcategories;
      if (map.containsKey(image.subcategories) == false) map[key] = [];

      map[key]?.add(image);
    }

    return map.values.toList();
  }

  ComicsState copyWith({
    required ComicsStatus status,
    String? errorMessage,
    List<SvgImage>? images,
  }) {
    return ComicsState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      images: images ?? _images,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        _images,
      ];
}
