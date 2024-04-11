import 'package:equatable/equatable.dart';

class ImageCategory extends Equatable {
  const ImageCategory({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory ImageCategory.fromJson(Map<String, dynamic> json) => ImageCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  List<Object?> get props => [id, name];
}
