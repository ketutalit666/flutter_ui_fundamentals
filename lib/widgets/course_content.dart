import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import 'course_card.dart';

class CourseContent extends StatelessWidget {
  final int? limit;

  const CourseContent({
    super.key,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              const Text('Materi gagal dimuat.'),
              const SizedBox(height: 8),
              SelectableText(provider.error!),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<CourseProvider>().loadCourses();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.courses.isEmpty) {
      return const Center(
        child: Text('Belum ada materi yang tersedia.'),
      );
    }

    final courses = limit == null
        ? provider.courses
        : provider.courses.take(limit!).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final course in courses)
          CourseCard(
            key: ValueKey(course.code),
            course: course,
          ),
      ],
    );
  }
}