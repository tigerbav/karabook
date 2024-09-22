class Progress {
  const Progress({
    this.id,
    required this.userId,
    required this.imageId,
    this.completedParts,
    this.isCompleted = false,
    this.modifiedDate,
  });

  final int? id;
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

  Map<String, dynamic> toJsonPut() {
    return {
      'imageProgressId': id,
      'completedImageParts': completedParts,
      'isCompleted': isCompleted,
      'modifiedDate': modifiedDate,
    };
  }

  Progress copyWith({
    int? id,
    int? userId,
    int? imageId,
    required String? completedParts,
    bool? isCompleted,
    int? modifiedDate,
  }) {
    return Progress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageId: imageId ?? this.imageId,
      completedParts: completedParts,
      isCompleted: isCompleted ?? this.isCompleted,
      modifiedDate: modifiedDate ?? this.modifiedDate,
    );
  }
}
