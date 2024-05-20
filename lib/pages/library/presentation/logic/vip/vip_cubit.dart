import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';

part 'vip_state.dart';

class VipCubit extends Cubit<VipState> {
  VipCubit({
    required this.repository,
    // required this.pack,
  }) : super(const VipState()) {
    // _loadImages();
  }

  final ILibraryRepository repository;
  // final Pack pack;

  // Future<void> _loadImages() async {
  //   emit(state.copyWith(status: VipStatus.loading));
  //
  //   final result = await repository.getAllImagesFromPack(pack.packName);
  //   result.fold(
  //     (l) => emit(state.copyWith(
  //       status: VipStatus.failure,
  //       messageError: l.errorMessage,
  //     )),
  //     (r) {
  //       emit(state.copyWith(
  //         status: VipStatus.success,
  //         images: r,
  //       ));
  //     },
  //   );
  // }
}
