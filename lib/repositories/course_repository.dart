import '../models/course.dart';
import '../services/course_service.dart';

class CourseRepository {
  final CourseService service;

  CourseRepository(this.service);

  // Mengambil seluruh data mata kuliah
  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }

  // Menambahkan mata kuliah
  Future<Course> addCourse(Course course) {
    return service.createCourse(course);
  }

  // Memperbarui seluruh data mata kuliah
  Future<Course> updateCourse(Course course) {
    return service.updateCourse(course);
  }

  // Memperbarui sebagian data mata kuliah
  Future<Course> patchCourse(
    String id,
    Map<String, dynamic> updates,
  ) {
    return service.patchCourse(id, updates);
  }

  // Menghapus mata kuliah
  Future<void> deleteCourse(String id) {
    return service.deleteCourse(id);
  }
}