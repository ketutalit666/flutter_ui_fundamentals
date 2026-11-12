
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../screens/detail_page.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  // UPDATE: menampilkan form edit mata kuliah.
  Future<void> _showEditDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();

    final codeController = TextEditingController(text: course.code);
    final titleController = TextEditingController(text: course.title);
    final creditsController =
        TextEditingController(text: course.credits.toString());
    final statusController = TextEditingController(text: course.status);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Mata Kuliah'),
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
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kode wajib diisi';
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
                        return 'Judul wajib diisi';
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
                        return 'Jumlah SKS tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Status wajib diisi';
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
            Consumer<CourseProvider>(
              builder: (context, provider, child) {
                return FilledButton(
                  onPressed: provider.isSaving
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          if (course.id == null) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'ID mata kuliah tidak ditemukan.',
                                ),
                              ),
                            );
                            return;
                          }

                          final updatedCourse = Course(
                            id: course.id,
                            code: codeController.text.trim(),
                            title: titleController.text.trim(),
                            credits: int.parse(
                              creditsController.text.trim(),
                            ),
                            status: statusController.text.trim(),
                          );

                          try {
                            await context
                                .read<CourseProvider>()
                                .updateCourse(updatedCourse);

                            if (!dialogContext.mounted) return;

                            Navigator.pop(dialogContext);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Mata kuliah berhasil diperbarui.',
                                ),
                              ),
                            );
                          } catch (e) {
                            if (!dialogContext.mounted) return;

                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Gagal memperbarui data: $e',
                                ),
                              ),
                            );
                          }
                        },
                  child: provider.isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Simpan Perubahan'),
                );
              },
            ),
          ],
        );
      },
    );

    codeController.dispose();
    titleController.dispose();
    creditsController.dispose();
    statusController.dispose();
  }

  // DELETE: konfirmasi penghapusan mata kuliah.
  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Mata Kuliah?'),
          content: Text(
            'Apakah bos yakin ingin menghapus '
            '"${course.title}" dari database?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    if (course.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID mata kuliah tidak ditemukan.'),
        ),
      );
      return;
    }

    try {
      await context.read<CourseProvider>().deleteCourse(course.id!);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mata kuliah berhasil dihapus.'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus mata kuliah: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        final favorite = provider.isFavorite(course.code);

        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(course: course),
                ),
              );
            },
            leading: CircleAvatar(
              child: Text(
                course.code.length >= 2
                    ? course.code.substring(0, 2)
                    : course.code,
              ),
            ),
            title: Text(
              course.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${course.code} • ${course.credits} SKS\n'
              'Status: ${course.status}',
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton<String>(
                  tooltip: 'Kelola mata kuliah',
                  enabled: course.id != null && !provider.isSaving,
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditDialog(context);
                    } else if (value == 'delete') {
                      _showDeleteDialog(context);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined),
                          SizedBox(width: 8),
                          Text('Edit Mata Kuliah'),
                        ],
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Hapus Mata Kuliah',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
                IconButton(
                  tooltip: favorite
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  icon: Icon(
                    favorite ? Icons.star : Icons.star_border,
                    color: favorite ? Colors.amber : null,
                  ),
                  onPressed: () {
                    context
                        .read<CourseProvider>()
                        .toggleFavorite(course.code);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
