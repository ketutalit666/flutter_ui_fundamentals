
import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> courses = [];

  // Favorit disimpan berdasarkan kode mata kuliah.
  final Set<String> favorites = {};

  bool isLoading = false;
  bool isSaving = false;
  String? error;

  // READ: mengambil data dari sumber aktif.
  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();

      debugPrint(
        'Data berhasil dimuat: ${courses.length} mata kuliah',
      );
    } catch (e) {
      error = 'Gagal memuat materi: $e';
      debugPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // FAVORITE: memeriksa status favorit.
  bool isFavorite(String code) {
    return favorites.contains(code);
  }

  // FAVORITE: menambah atau menghapus favorit.
  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }

    notifyListeners();
  }

  // CREATE: menambahkan mata kuliah.
  Future<void> addCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final newCourse = await repository.addCourse(course);

      courses.add(newCourse);

      debugPrint(
        'Mata kuliah berhasil ditambahkan: ${newCourse.title}',
      );
    } catch (e) {
      error = 'Gagal menambahkan mata kuliah: $e';
      debugPrint(error);
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // UPDATE: memperbarui mata kuliah.
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

      debugPrint(
        'Mata kuliah berhasil diperbarui: ${updatedCourse.title}',
      );
    } catch (e) {
      error = 'Gagal memperbarui mata kuliah: $e';
      debugPrint(error);
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // DELETE: menghapus mata kuliah.
  Future<void> deleteCourse(String id) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final index = courses.indexWhere(
        (item) => item.id == id,
      );

      if (index == -1) {
        throw Exception('Mata kuliah tidak ditemukan.');
      }

      final deletedCourse = courses[index];

      await repository.deleteCourse(id);

      courses.removeWhere(
        (item) => item.id == id,
      );

      favorites.remove(deletedCourse.code);

      debugPrint(
        'Mata kuliah berhasil dihapus: ${deletedCourse.title}',
      );
    } catch (e) {
      error = 'Gagal menghapus mata kuliah: $e';
      debugPrint(error);
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
}
