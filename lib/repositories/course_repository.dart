
import '../models/course.dart';
import '../services/course_data_source.dart';

class CourseRepository {
  final CourseDataSource dataSource;

  CourseRepository(this.dataSource);

  // READ: mengambil seluruh data mata kuliah.
  Future<List<Course>> getCourses() {
    return dataSource.loadCourses();
  }

  // CREATE: menambahkan mata kuliah.
  Future<Course> addCourse(Course course) {
    return dataSource.createCourse(course);
  }

  // UPDATE: memperbarui data mata kuliah.
  Future<Course> updateCourse(Course course) {
    return dataSource.updateCourse(course);
  }

  // DELETE: menghapus mata kuliah.
  Future<void> deleteCourse(String id) {
    return dataSource.deleteCourse(id);
  }
}
