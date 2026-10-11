import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import 'course_card.dart';

class CourseContent extends StatelessWidget {
  final int? limit;

  const CourseContent({super.key, this.limit});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 40),
                  const SizedBox(height: 12),
                  SelectableText(provider.error!),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: provider.loadCourses,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        if (provider.courses.isEmpty) {
          return const Center(child: Text('Belum ada materi tersedia.'));
        }

        final courses = limit == null
            ? provider.courses
            : provider.courses.take(limit!).toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return CourseCard(course: courses[index]);
          },
        );
      },
    );
  }
}
