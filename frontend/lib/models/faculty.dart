import 'package:smart_insti_app/models/course.dart';

class Faculty {
  final String id;
  final String name;
  final String email;
  final List<Course> courses;

  Faculty({
    required this.id,
    required this.name,
    required this.email,
    required this.courses,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['_id'],
      name: json['name'] ?? 'Smart Insti User',
      email: json['email'],
      courses: (json['courses'] as List)
          .map((item) => Course.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'courses': courses,
    };
  }
}
