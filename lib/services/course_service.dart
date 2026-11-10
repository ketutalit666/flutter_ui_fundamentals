
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseService {
  static const String baseUrl =
      'https://course-api-pearl.vercel.app';

  // HTTP GET: mengambil seluruh data mata kuliah
  Future<List<Course>> loadCourses() async {
    final url = Uri.parse('$baseUrl/courses');

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 15));

      debugPrint('HTTP GET: $url');
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
      }

      throw Exception(
        'Gagal mengambil data. Status Code: ${response.statusCode}',
      );
    } on FormatException {
      throw Exception('Format JSON dari server tidak valid.');
    } on http.ClientException catch (e) {
      throw Exception('Kesalahan koneksi API: $e');
    }
  }

  // HTTP POST: menambahkan mata kuliah
  Future<Course> createCourse(Course course) async {
    final url = Uri.parse('$baseUrl/courses');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
      }),
    ).timeout(const Duration(seconds: 15));

    debugPrint('HTTP POST: $url');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode == 201) {
      final data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Course.fromJson(data);
    }

    throw Exception(
      'Gagal menambahkan mata kuliah. '
      'Status Code: ${response.statusCode}. ${response.body}',
    );
  }

  // HTTP PUT: memperbarui seluruh data mata kuliah
  Future<Course> updateCourse(Course course) async {
    if (course.id == null) {
      throw Exception('ID mata kuliah tidak ditemukan.');
    }

    final url = Uri.parse('$baseUrl/courses/${course.id}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
      }),
    ).timeout(const Duration(seconds: 15));

    debugPrint('HTTP PUT: $url');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Course.fromJson(data);
    }

    throw Exception(
      'Gagal memperbarui seluruh data. '
      'Status Code: ${response.statusCode}. ${response.body}',
    );
  }

  // HTTP PATCH: memperbarui sebagian data mata kuliah
  Future<Course> patchCourse(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final url = Uri.parse('$baseUrl/courses/$id');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updates),
    ).timeout(const Duration(seconds: 15));

    debugPrint('HTTP PATCH: $url');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Course.fromJson(data);
    }

    throw Exception(
      'Gagal memperbarui sebagian data. '
      'Status Code: ${response.statusCode}. ${response.body}',
    );
  }
}
