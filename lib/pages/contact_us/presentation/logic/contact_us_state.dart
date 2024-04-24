part of 'contact_us_cubit.dart';

enum ContactUsStatus { initial, loading, failure, success, idle }

class ContactUsState extends Equatable {
  const ContactUsState({
    this.status = ContactUsStatus.initial,
    this.files = const [],
    this.errorMessage,
  });

  final ContactUsStatus status;
  final List<File> files;
  final String? errorMessage;

  bool get isFailure => status == ContactUsStatus.failure;
  bool get isLoading => status == ContactUsStatus.loading;
  bool get isSuccess => status == ContactUsStatus.success;

  ContactUsState copyWith({
    required ContactUsStatus status,
    List<File>? files,
    String? errorMessage,
  }) {
    return ContactUsState(
      status: status,
      files: files ?? this.files,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, files, errorMessage];
}
