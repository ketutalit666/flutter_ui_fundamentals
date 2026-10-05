import 'package:flutter/material.dart';

const String studentName = 'I Ketut Alit Junaedi Wardana';
const String studentId = '2415051050';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 9 - Returning Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ==================== DATA COURSE ====================

final List<Map<String, dynamic>> courses = [
  {
    'code': 'FL001',
    'title': 'Flutter UI Fundamentals',
    'credits': 3,
    'status': 'Selesai',
  },
  {
    'code': 'FL002',
    'title': 'Widget dan Layout Flutter',
    'credits': 3,
    'status': 'Berjalan',
  },
  {
    'code': 'FL003',
    'title': 'Responsive Layout',
    'credits': 3,
    'status': 'Berjalan',
  },
];

// ==================== HOME PAGE ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> openCourseDetail(
    BuildContext context,
    Map<String, dynamic> course,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailPage(
          course: course,
        ),
      ),
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${course['title']} berhasil ditandai selesai.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  course['code'].toString().substring(2),
                ),
              ),
              title: Text(course['title']),
              subtitle: Text(
                '${course['code']} • '
                '${course['credits']} SKS • '
                '${course['status']}',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                openCourseDetail(
                  context,
                  course,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ==================== DETAIL PAGE ====================

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.menu_book,
              size: 80,
            ),

            const SizedBox(height: 20),

            Text(
              course['title'],
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Course: ${course['code']}',
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'SKS: ${course['credits']}',
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Status: ${course['status']}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Data Mahasiswa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text('Nama: $studentName'),

            const SizedBox(height: 5),

            Text('NIM: $studentId'),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(
                    context,
                    true,
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text(
                  'Tandai Selesai',
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
                child: const Text(
                  'Kembali Tanpa Menyelesaikan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}