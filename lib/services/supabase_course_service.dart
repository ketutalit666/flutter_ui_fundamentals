import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';

class SupabaseCourseService {
  final SupabaseClient client = Supabase.instance.client;

  // SELECT: mengambil seluruh data mata kuliah
  Future<List<Course>> loadCourses() async {
    try {
      final response = await client
          .from('courses')
          .select()
          .order('id', ascending: true);

      final courses = response
          .map((item) => Course.fromJson(item))
          .toList();

      debugPrint('Supabase SELECT berhasil');
      debugPrint('Jumlah data: ${courses.length}');

      return courses;
    } catch (e) {
      debugPrint('Supabase SELECT gagal: $e');
      rethrow;
    }
  }

  // INSERT: menambahkan mata kuliah baru
  Future<Course> insertCourse(Course course) async {
    try {
      final response = await client
          .from('courses')
          .insert({
            'code': course.code,
            'title': course.title,
            'credits': course.credits,
            'status': course.status,
          })
          .select()
          .single();

      final newCourse = Course.fromJson(response);

      debugPrint('Supabase INSERT berhasil');
      debugPrint('Mata kuliah: ${newCourse.title}');
      debugPrint('ID baru: ${newCourse.id}');

      return newCourse;
    } catch (e) {
      debugPrint('Supabase INSERT gagal: $e');
      rethrow;
    }
  }
}