import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../screens/detail_page.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        final favorite = provider.isFavorite(course.code);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(course: course)),
              );
            },
            leading: CircleAvatar(child: Text(course.code.substring(0, 2))),
            title: Text(
              course.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${course.code} • ${course.credits} SKS\nStatus: ${course.status}',
            ),
            isThreeLine: true,
            trailing: IconButton(
              tooltip: favorite ? 'Hapus dari favorit' : 'Tambahkan ke favorit',
              icon: Icon(
                favorite ? Icons.star : Icons.star_border,
                color: favorite ? Colors.amber : null,
              ),
              onPressed: () {
                context.read<CourseProvider>().toggleFavorite(course.code);
              },
            ),
          ),
        );
      },
    );
  }
}
