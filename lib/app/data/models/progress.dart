class Progress {
  const Progress({
    required this.id,
    required this.userId,
    required this.imageId,
    this.completedParts,
    this.isCompleted = false,
    this.modifiedDate,
  });

  final int id;
  final int userId;
  final int imageId;
  final String? completedParts;
  final bool isCompleted;
  final int? modifiedDate;

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['imageProgressId'] as int,
      userId: json['userId'] as int,
      imageId: json['imageId'] as int,
      completedParts: json['completedImageParts'] as String?,
      isCompleted: json['isCompleted'] as bool,
      modifiedDate: json['modifiedDate'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'imageId': imageId,
      'completedImageParts': completedParts,
      'isCompleted': isCompleted,
    };
  }
}
