import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class DetailPage extends StatelessWidget {
  final Course course;

  const DetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Materi')),
      body: Consumer<CourseProvider>(
        builder: (context, provider, child) {
          final favorite = provider.isFavorite(course.code);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const CircleAvatar(
                radius: 36,
                child: Icon(Icons.menu_book, size: 36),
              ),
              const SizedBox(height: 20),
              Text(
                course.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kode materi: ${course.code}'),
                      const SizedBox(height: 12),
                      Text('Jumlah SKS: ${course.credits}'),
                      const SizedBox(height: 12),
                      Text('Status: ${course.status}'),
                      const SizedBox(height: 12),
                      Text('Favorit: ${favorite ? "Ya" : "Tidak"}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  provider.toggleFavorite(course.code);
                },
                icon: Icon(favorite ? Icons.star : Icons.star_border),
                label: Text(
                  favorite ? 'Hapus dari Favorit' : 'Tambahkan ke Favorit',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
