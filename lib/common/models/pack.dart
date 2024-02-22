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

  @override
  List<Object?> get props => [
        id,
        packName,
        packIcon,
        packDescription,
        packsIdentifier,
      ];
}
