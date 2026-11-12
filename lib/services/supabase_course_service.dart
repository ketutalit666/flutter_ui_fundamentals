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

  // INSERT: menambahkan mata kuliah
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

      debugPrint('Supabase INSERT berhasil: ${newCourse.title}');

      return newCourse;
    } catch (e) {
      debugPrint('Supabase INSERT gagal: $e');
      rethrow;
    }
  }

  // UPDATE: memperbarui seluruh data mata kuliah
  Future<Course> updateCourse(Course course) async {
    try {
      if (course.id == null) {
        throw Exception('ID mata kuliah tidak ditemukan.');
      }

      final id = int.tryParse(course.id!);

      if (id == null) {
        throw Exception('Format ID mata kuliah tidak valid.');
      }

      final response = await client
          .from('courses')
          .update({
            'code': course.code,
            'title': course.title,
            'credits': course.credits,
            'status': course.status,
          })
          .eq('id', id)
          .select()
          .single();

      final updatedCourse = Course.fromJson(response);

      debugPrint('Supabase UPDATE berhasil: ${updatedCourse.title}');

      return updatedCourse;
    } catch (e) {
      debugPrint('Supabase UPDATE gagal: $e');
      rethrow;
    }
  }

  // DELETE: menghapus mata kuliah berdasarkan ID
  Future<void> deleteCourse(String courseId) async {
    try {
      final id = int.tryParse(courseId);

      if (id == null) {
        throw Exception('Format ID mata kuliah tidak valid.');
      }

      final response = await client
          .from('courses')
          .delete()
          .eq('id', id)
          .select('id');

      if (response.isEmpty) {
        throw Exception(
          'Data tidak ditemukan atau tidak memiliki izin untuk dihapus.',
        );
      }

      debugPrint('Supabase DELETE berhasil. ID: $id');
    } catch (e) {
      debugPrint('Supabase DELETE gagal: $e');
      rethrow;
    }
  }
}