import '../models/course.dart';
import '../services/course_service.dart';
import '../services/supabase_course_service.dart';

class CourseRepository {
  final CourseService service;
  final SupabaseCourseService supabaseService;

  CourseRepository(
    this.service, {
    SupabaseCourseService? supabaseService,
  }) : supabaseService = supabaseService ?? SupabaseCourseService();

  // REST API GET
  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }

  // SUPABASE SELECT
  Future<List<Course>> getSupabaseCourses() {
    return supabaseService.loadCourses();
  }

  // REST API POST
  Future<Course> addCourse(Course course) {
    return service.createCourse(course);
  }

  // SUPABASE INSERT
  Future<Course> addSupabaseCourse(Course course) {
    return supabaseService.insertCourse(course);
  }

  // REST API PUT
  Future<Course> updateCourse(Course course) {
    return service.updateCourse(course);
  }

  // SUPABASE UPDATE
  Future<Course> updateSupabaseCourse(Course course) {
    return supabaseService.updateCourse(course);
  }

  // REST API PATCH
  Future<Course> patchCourse(
    String id,
    Map<String, dynamic> updates,
  ) {
    return service.patchCourse(id, updates);
  }

  // REST API DELETE
  Future<void> deleteCourse(String id) {
    return service.deleteCourse(id);
  }

  // SUPABASE DELETE
  Future<void> deleteSupabaseCourse(String id) {
    return supabaseService.deleteCourse(id);
  }
}