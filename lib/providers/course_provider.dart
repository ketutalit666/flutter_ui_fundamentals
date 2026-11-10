
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

  Future<void> addCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final newCourse = await repository.addCourse(course);
      courses.add(newCourse);
    } catch (e) {
      error = 'Gagal menambahkan materi: $e';
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Memperbarui seluruh data menggunakan PUT
  Future<void> updateCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final updatedCourse =
          await repository.updateCourse(course);

      final index = courses.indexWhere(
        (item) => item.id == updatedCourse.id,
      );

      if (index != -1) {
        courses[index] = updatedCourse;
      }
    } catch (e) {
      error = 'Gagal memperbarui materi: $e';
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Memperbarui sebagian data menggunakan PATCH
  Future<void> patchCourse(
    String id,
    Map<String, dynamic> updates,
  ) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final updatedCourse =
          await repository.patchCourse(id, updates);

      final index = courses.indexWhere(
        (item) => item.id == updatedCourse.id,
      );

      if (index != -1) {
        courses[index] = updatedCourse;
      }
    } catch (e) {
      error = 'Gagal memperbarui sebagian materi: $e';
      rethrow;
    } finally {
      isSaving = false;
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
}
