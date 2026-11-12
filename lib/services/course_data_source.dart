
import '../models/course.dart';

abstract class CourseDataSource {
  Future<List<Course>> loadCourses();

  Future<Course> createCourse(Course course);

  Future<Course> updateCourse(Course course);

  Future<void> deleteCourse(String id);
}
