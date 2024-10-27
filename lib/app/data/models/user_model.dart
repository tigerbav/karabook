class UserModel {
  UserModel({
    required this.id,
    this.hintsAmount = 0,
    this.userEmail,
  });

  final int id;
  final int hintsAmount;
  final String? userEmail;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'],
      hintsAmount: json['hintsAmount'] ?? 2,
      userEmail: json['userEmail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'hintsAmount': hintsAmount,
    };
  }
}
