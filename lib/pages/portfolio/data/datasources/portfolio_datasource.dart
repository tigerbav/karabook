import 'package:karabookapp/common/models/svg_image.dart';

abstract class IPortfolioDataSources {
  Future<List<SvgImage>> getCurrentImages();
  Future<List<SvgImage>> getCompletedImages();
}

class PortfolioDataSources extends IPortfolioDataSources {
  @override
  Future<List<SvgImage>> getCompletedImages() async {
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
  Future<List<SvgImage>> getCurrentImages() async {
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
    ];
  }
}
