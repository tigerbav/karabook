import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karabookapp/pages/contact_us/domain/repositories/contact_us_repository.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this._repository) : super(const ContactUsState());
  final IContactUsRepository _repository;

  void openImagePicker() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      final files = List<File>.from(state.files);
      files.add(File(xFile.path));
      emit(state.copyWith(
        status: ContactUsStatus.idle,
        files: files,
      ));
    }
  }

  void deleteImage(File file) {
    final files = List<File>.from(state.files);

    files.remove(file);

    emit(state.copyWith(
      status: ContactUsStatus.idle,
      files: files,
    ));
  }

  Future<void> send(String message) async {
    final result = await _repository.sendEmail(
      message: message,
      files: state.files,
    );

    result.fold(
      (l) => emit(state.copyWith(
        status: ContactUsStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) => emit(state.copyWith(status: ContactUsStatus.success)),
    );
  }

  void resetFailure() => emit(state.copyWith(status: ContactUsStatus.idle));
}
