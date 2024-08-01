import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/services/in_app_purchases/purchases_manager.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

part 'vip_state.dart';

class VipCubit extends Cubit<VipState> {
  VipCubit({
    required this.repository,
    required this.pack,
  }) : super(const VipState()) {
    _init();
  }

  final ILibraryRepository repository;
  final CategoryModel pack;

  Future<void> _init() async {
    emit(state.copyWith(status: VipStatus.loading));
    final id = pack.nameKey?.replaceAll('-', '_') ?? '';
    final isAvailable = await PurchasesManager.shared.check(id);
    Offering? result;

    if (isAvailable == false) {
      result = await PurchasesManager.shared.fetch(id);
    }
    emit(state.copyWith(
      status: VipStatus.loading,
      offering: result,
      isAvailable: isAvailable,
    ));

    await _loadImages();
  }

  Future<void> _loadImages() async {
    final result = await repository.getAllImagesFromPack(pack.id);
    result.fold(
      (l) => emit(state.copyWith(
        status: VipStatus.failure,
        messageError: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          status: VipStatus.success,
          images: r.toSet().toList(),
        ));
      },
    );
    final query =
        isar.painterProgress.filter().isCompletedEqualTo(true).build();
    final stream = query.watch(fireImmediately: true);

    stream.listen((event) {
      final ids = state.images.map((e) => e.id).toList();
      var progressStep = 0;
      for (final id in ids) {
        if (event.firstWhereOrNull((e) => e.id == id) == null) continue;
        progressStep++;
      }

      emit(state.copyWith(
        status: VipStatus.idle,
        progressStep: progressStep,
      ));
    });
  }

  Future<void> buy() async {
    if (state.isAvailable) return;
    if (state.offering?.lifetime == null) return;
    final result = await PurchasesManager.shared.buy(state.offering!.lifetime!);
    if (result == false) return;

    emit(state.copyWith(
      status: VipStatus.idle,
      isAvailable: true,
    ));
  }
}
