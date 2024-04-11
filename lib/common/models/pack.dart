import 'package:equatable/equatable.dart';

class Pack extends Equatable {
  const Pack({
    required this.id,
    required this.packName,
    required this.packIcon,
    required this.packDescription,
    required this.packsIdentifier,
  });

  final int id;
  final String packName;
  final String packIcon;
  final String packDescription;
  final String packsIdentifier;

  factory Pack.fromJson(Map<String, dynamic> json) => Pack(
        id: json["id"],
        packName: json["packName"],
        packIcon: json["packIcon"],
        packDescription: json["packDescription"],
        packsIdentifier: json["packsIdentifier"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "packName": packName,
        "packIcon": packIcon,
        "packDescription": packDescription,
        "packsIdentifier": packsIdentifier,
      };

  @override
  List<Object?> get props => [
        id,
        packName,
        packIcon,
        packDescription,
        packsIdentifier,
      ];
}
