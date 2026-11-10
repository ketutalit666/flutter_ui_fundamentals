import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> courses = [];
  final Set<String> favorites = {};

  bool isLoading = false;
  bool isSaving = false;
  String? error;

  // Mengambil data dari REST API
  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = 'Gagal memuat materi: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Mengambil data dari Supabase
  Future<void> loadSupabaseCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getSupabaseCourses();

      debugPrint(
        'Data Supabase berhasil dimuat: ${courses.length} mata kuliah',
      );
    } catch (e) {
      error = 'Gagal memuat data dari Supabase: $e';
      debugPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String code) {
    return favorites.contains(code);
  }

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }

    notifyListeners();
  }

  Future<void> addCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final newCourse = await repository.addCourse(course);
      courses.add(newCourse);
    } catch (e) {
      error = 'Gagal menambahkan mata kuliah: $e';
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final updatedCourse = await repository.updateCourse(course);

      final index = courses.indexWhere(
        (item) => item.id == updatedCourse.id,
      );

      if (index != -1) {
        courses[index] = updatedCourse;
      }
    } catch (e) {
      error = 'Gagal memperbarui mata kuliah: $e';
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> patchCourse(
    String id,
    Map<String, dynamic> updates,
  ) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final updatedCourse = await repository.patchCourse(id, updates);

      final index = courses.indexWhere(
        (item) => item.id == updatedCourse.id,
      );

      if (index != -1) {
        courses[index] = updatedCourse;
      }
    } catch (e) {
      error = 'Gagal memperbarui sebagian data: $e';
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> deleteCourse(String id) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final index = courses.indexWhere(
        (item) => item.id == id,
      );

      if (index == -1) {
        throw Exception('Mata kuliah tidak ditemukan di daftar.');
      }

      final deletedCourse = courses[index];

      await repository.deleteCourse(id);

      courses.removeWhere((item) => item.id == id);
      favorites.remove(deletedCourse.code);
    } catch (e) {
      error = 'Gagal menghapus mata kuliah: $e';
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
}