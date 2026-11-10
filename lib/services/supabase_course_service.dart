import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';

class SupabaseCourseService {
  final SupabaseClient client = Supabase.instance.client;

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
}