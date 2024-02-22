import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';

abstract class ILibraryDataSource {
  Future<List<ImageCategory>> getAllCategories();
  Future<List<SvgImage>> getAllImages();
  Future<List<SvgImage>> getImagesByCategoryId();
}

class LibraryDataSource extends ILibraryDataSource {
  @override
  Future<List<ImageCategory>> getAllCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      const ImageCategory(id: 0, name: 'Nature'),
      const ImageCategory(id: 1, name: 'Animals & Birds'),
      const ImageCategory(id: 2, name: 'People'),
      const ImageCategory(id: 3, name: 'Butterflies'),
      const ImageCategory(id: 4, name: 'Mandalas'),
      const ImageCategory(id: 5, name: 'Fantasy Art'),
      const ImageCategory(id: 6, name: 'Transport'),
      const ImageCategory(id: 7, name: 'Interior'),
      const ImageCategory(id: 8, name: 'Flowers'),
      const ImageCategory(id: 9, name: 'Food'),
      const ImageCategory(id: 10, name: 'Cities'),
      const ImageCategory(id: 11, name: 'Exclusive Art'),
      const ImageCategory(id: 12, name: 'Vip'),
    ];
  }

  @override
  Future<List<SvgImage>> getAllImages() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      const SvgImage(
        id: 0,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Nature',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 1,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Flowers',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 2,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Exclusive Art',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 3,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Flowers',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 4,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Nature',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 5,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Nature',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 6,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Animals & Birds',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 7,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Butterflies',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 8,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Food',
        imageParts: '',
        subcategories: '',
      ),
    ];
  }

  @override
  Future<List<SvgImage>> getImagesByCategoryId() {
    // TODO: implement getImagesByCategoryId
    throw UnimplementedError();
  }
}
