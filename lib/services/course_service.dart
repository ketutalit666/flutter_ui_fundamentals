
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseService {
  static const String baseUrl =
      'https://course-api-pearl.vercel.app';

  Future<List<Course>> loadCourses() async {
    final url = Uri.parse('$baseUrl/courses');

    final response = await http.get(url);

    debugPrint('HTTP GET: ${url.toString()}');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body) as List<dynamic>;

      final courses = data
          .map(
            (item) => Course.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();

      debugPrint('Jumlah mata kuliah: ${courses.length}');

      return courses;
    } else {
      throw Exception(
        'Gagal mengambil data. Status Code: ${response.statusCode}',
      );
    }
  }
}
