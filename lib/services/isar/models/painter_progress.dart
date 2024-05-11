import 'package:isar/isar.dart';

part 'painter_progress.g.dart';

@collection
class PainterProgress {
  late Id id;
  bool isCompleted = false;
  // this value should be Uint8List
  List<int>? completedIds;
  List<int>? screenProgress;
}
