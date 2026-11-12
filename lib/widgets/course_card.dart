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

  // REST API PUT
  Future<void> _showEditDialog(BuildContext context) async {
    final codeController = TextEditingController(text: course.code);
    final titleController = TextEditingController(text: course.title);
    final creditsController =
        TextEditingController(text: course.credits.toString());
    final statusController = TextEditingController(text: course.status);

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Mata Kuliah (PUT)'),
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
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Kode wajib diisi'
                            : null,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Judul Mata Kuliah',
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Judul wajib diisi'
                            : null,
                  ),
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
                  TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Status wajib diisi'
                            : null,
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
                if (!formKey.currentState!.validate()) return;

                final updatedCourse = Course(
                  id: course.id,
                  code: codeController.text.trim(),
                  title: titleController.text.trim(),
                  credits: int.parse(creditsController.text.trim()),
                  status: statusController.text.trim(),
                );

                try {
                  await context
                      .read<CourseProvider>()
                      .updateCourse(updatedCourse);

                  if (!context.mounted || !dialogContext.mounted) return;

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mata kuliah berhasil diperbarui melalui REST PUT.',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!dialogContext.mounted) return;

                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text('Gagal memperbarui data: $e'),
                    ),
                  );
                }
              },
              child: const Text('Simpan PUT'),
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

  // REST API PATCH
  Future<void> _showPatchDialog(BuildContext context) async {
    final titleController = TextEditingController(text: course.title);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Judul (PATCH)'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Judul Mata Kuliah',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () async {
                final newTitle = titleController.text.trim();

                if (newTitle.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Judul mata kuliah wajib diisi.'),
                    ),
                  );
                  return;
                }

                if (course.id == null) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('ID mata kuliah tidak ditemukan.'),
                    ),
                  );
                  return;
                }

                try {
                  await context.read<CourseProvider>().patchCourse(
                    course.id!,
                    {'title': newTitle},
                  );

                  if (!context.mounted || !dialogContext.mounted) return;

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Judul berhasil diperbarui melalui PATCH.',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!dialogContext.mounted) return;

                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text('Gagal memperbarui judul: $e'),
                    ),
                  );
                }
              },
              child: const Text('Simpan PATCH'),
            ),
          ],
        );
      },
    );

    titleController.dispose();
  }

  // SUPABASE UPDATE
  Future<void> _showSupabaseUpdateDialog(
    BuildContext context,
  ) async {
    final codeController = TextEditingController(text: course.code);
    final titleController = TextEditingController(text: course.title);
    final creditsController =
        TextEditingController(text: course.credits.toString());
    final statusController = TextEditingController(text: course.status);

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Mata Kuliah (Supabase UPDATE)'),
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
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Kode wajib diisi'
                            : null,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Judul Mata Kuliah',
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Judul wajib diisi'
                            : null,
                  ),
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
                  TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Status wajib diisi'
                            : null,
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
                if (!formKey.currentState!.validate()) return;

                if (course.id == null) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('ID mata kuliah tidak ditemukan.'),
                    ),
                  );
                  return;
                }

                final updatedCourse = Course(
                  id: course.id,
                  code: codeController.text.trim(),
                  title: titleController.text.trim(),
                  credits: int.parse(creditsController.text.trim()),
                  status: statusController.text.trim(),
                );

                try {
                  await context
                      .read<CourseProvider>()
                      .updateSupabaseCourse(updatedCourse);

                  if (!context.mounted || !dialogContext.mounted) return;

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Data berhasil diperbarui di Supabase.',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!dialogContext.mounted) return;

                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text('Gagal memperbarui Supabase: $e'),
                    ),
                  );
                }
              },
              child: const Text('Simpan UPDATE'),
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

  // SUPABASE DELETE
  Future<void> _showDeleteSupabaseDialog(
    BuildContext context,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Mata Kuliah?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus '
            '"${course.title}" dari database Supabase?',
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
      await context
          .read<CourseProvider>()
          .deleteSupabaseCourse(course.id!);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus dari Supabase.'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus data: $e'),
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
                  enabled: course.id != null,
                  onSelected: (value) {
                    if (value == 'put') {
                      _showEditDialog(context);
                    } else if (value == 'patch') {
                      _showPatchDialog(context);
                    } else if (value == 'supabase_update') {
                      _showSupabaseUpdateDialog(context);
                    } else if (value == 'supabase_delete') {
                      _showDeleteSupabaseDialog(context);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'put',
                      child: Text('Edit seluruh data (REST PUT)'),
                    ),
                    PopupMenuItem(
                      value: 'patch',
                      child: Text('Edit judul saja (REST PATCH)'),
                    ),
                    PopupMenuItem(
                      value: 'supabase_update',
                      child: Text('Edit seluruh data (Supabase)'),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 'supabase_delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Hapus data (Supabase)',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.edit_outlined),
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