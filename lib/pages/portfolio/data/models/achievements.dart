import 'package:equatable/equatable.dart';

class Achievements extends Equatable {
  const Achievements(
      {required this.icon,
      required this.title,
      required this.counter,
      required this.current,
      required this.subTitle,
      required this.category,
      required this.progress});

  final String icon;
  final String title;
  final int counter;
  final int current;
  final String subTitle;
  final String category;
  final double progress;

  factory Achievements.fromJson(Map<String, dynamic> json) => Achievements(
        icon: json["icon"],
        title: json["title"],
        counter: json["counter"],
        current: json["current"],
        subTitle: json["subTitle"],
        category: json["category"],
        progress: json["progress"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "title": title,
        "counter": counter,
        "current": current,
        "subTitle": subTitle,
        "category": category,
        "progress": progress,
      };

  @override
  List<Object?> get props => [
        icon,
        title,
        counter,
        current,
        subTitle,
        category,
        progress,
      ];
}
