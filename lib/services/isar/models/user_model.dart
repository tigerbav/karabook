import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  UserModel({
    required this.id,
    this.userEmail,
  });

  final Id id;
  final String? userEmail;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'],
      userEmail: json['userEmail'],
    );
  }
}
