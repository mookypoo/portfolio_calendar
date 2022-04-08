import 'dart:ui';

class UserColor {
  final String title;
  final Color color;

  UserColor({required this.title, required this.color});

  factory UserColor.fromJson(Map<String, dynamic> json) => UserColor(
    color: Color(json["color"] as int),
    title: json["title"].toString(),
  );

  Map<String, dynamic> toJson(){
    return {
      "color": this.color.value,
      "title": this.title,
    };
  }
}