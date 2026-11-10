
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseService {
  static const String baseUrl =
      'https://course-api-pearl.vercel.app';

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
      } else {
        throw Exception(
          'Gagal mengambil data. Status Code: ${response.statusCode}',
        );
      }
    } on FormatException {
      throw Exception('Format JSON dari server tidak valid.');
    } on http.ClientException catch (e) {
      throw Exception('Kesalahan koneksi API: $e');
    } catch (e) {
      debugPrint('Terjadi kesalahan: $e');
      rethrow;
    }
  }

  // HTTP POST untuk menambahkan mata kuliah
  Future<Course> createCourse(Course course) async {
    final url = Uri.parse('$baseUrl/courses');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
      }),
    ).timeout(const Duration(seconds: 15));

    debugPrint('HTTP POST: $url');
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response: ${response.body}');

    if (response.statusCode == 201) {
      final data =
          jsonDecode(response.body) as Map<String, dynamic>;

      return Course.fromJson(data);
    } else {
      throw Exception(
        'Gagal menambahkan mata kuliah. '
        'Status Code: ${response.statusCode}. '
        'Pesan: ${response.body}',
      );
    }
  }
}
