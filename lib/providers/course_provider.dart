
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

  // Menambahkan mata kuliah baru
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
