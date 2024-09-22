import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/events/presentation/logic/comics/comics_cubit.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';
import 'package:karabookapp/pages/library/presentation/logic/vip/vip_cubit.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

enum ImageType { byCategory, daily, paidComics, freeComics, portfolio }

extension ImageTypeEx on ImageType {
  Future<List<ImageModel>> getFromIsar({
    required int? categoryId,
    required int lastIndex,
  }) async {
    final List<ImageModel> models;
    switch (this) {
      case ImageType.byCategory:
        models = await isar.imageModels
            .filter()
            .categoryIdEqualTo(categoryId)
            .isDailyEqualTo(false)
            // .offset(lastIndex)
            // .limit(C.imageOnPage)
            .findAll();
//-------------------------------------------
      case ImageType.daily:
        models = await isar.imageModels.filter().isDailyEqualTo(true).findAll();
//-------------------------------------------
      case ImageType.paidComics:
        models = await isar.imageModels
            .filter()
            .categoryIdEqualTo(categoryId)
            // .offset(lastIndex)
            // .limit(C.imageOnPage)
            .findAll();
//-------------------------------------------
      case ImageType.freeComics:
        models = await isar.imageModels
            .filter()
            .categoryIdEqualTo(categoryId)
            // .offset(lastIndex)
            .findAll();
      case ImageType.portfolio:
        return [];
    }
    return models;
  }

  Future<void> updImage(BuildContext context, ImageModel model) async {
    ImageType type = this;

    if (this == ImageType.portfolio) {
      final categoryList = await IsarService.shared.getObjects(
        from: isar.categoryModels,
      );

      final category = categoryList.firstWhereOrNull(
        (e) => e.id == model.categoryId,
      );

      final categoryTypeId = category?.categoryTypeId;

      if (categoryTypeId == C.categoryTypeId && model.isDaily == true) {
        type = ImageType.daily;
      } else if (categoryTypeId == C.categoryTypeId) {
        type = ImageType.byCategory;
      } else if (categoryTypeId == C.packTypeId) {
        type = ImageType.freeComics;
      }
    }

    switch (type) {
      case ImageType.byCategory:
        context.read<LibraryCubit>().updImage(model);
      case ImageType.paidComics:
        context.read<VipCubit>().updImage(model);
      case ImageType.daily:
        context.read<DailyCubit>().updImage(model);
      case ImageType.freeComics:
        context.read<ComicsCubit>().updImage(model);
      case ImageType.portfolio:
    }
  }
}
