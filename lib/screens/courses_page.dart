
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_content.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  Future<void> _showAddCourseDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final codeController = TextEditingController();
    final titleController = TextEditingController();
    final creditsController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tambah Mata Kuliah'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: codeController,
                    decoration: const InputDecoration(
                      labelText: 'Kode Mata Kuliah',
                      hintText: 'Contoh: IF101',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kode mata kuliah wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Judul Mata Kuliah',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Judul mata kuliah wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: creditsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah SKS',
                    ),
                    validator: (value) {
                      final credits = int.tryParse(value ?? '');

                      if (credits == null || credits <= 0) {
                        return 'Masukkan jumlah SKS yang valid';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                final course = Course(
                  code: codeController.text.trim(),
                  title: titleController.text.trim(),
                  credits: int.parse(creditsController.text.trim()),
                  status: 'planned',
                );

                try {
                  await context.read<CourseProvider>().insertSupabaseCourse(course);

                  if (!context.mounted) return;

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mata kuliah berhasil ditambahkan.',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!dialogContext.mounted) return;

                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text('Gagal menambahkan data: $e'),
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    codeController.dispose();
    titleController.dispose();
    creditsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () => _showAddCourseDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Tambah Mata Kuliah'),
            ),
          ),
        ),
        const Expanded(
          child: CourseContent(),
        ),
      ],
    );
  }
}
