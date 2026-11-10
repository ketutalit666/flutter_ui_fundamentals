import '../models/course.dart';
import '../services/course_service.dart';

class CourseRepository {
  final CourseService service;

  CourseRepository(this.service);

  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }

  Future<Course> addCourse(Course course) {
    return service.createCourse(course);
  }

  Future<Course> updateCourse(Course course) {
    return service.updateCourse(course);
  }

  Future<Course> patchCourse(
    String id,
    Map<String, dynamic> updates,
  ) {
    return service.patchCourse(id, updates);
  }

  Future<void> deleteCourse(String id) {
    return service.deleteCourse(id);
  }
}