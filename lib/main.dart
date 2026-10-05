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
      title: 'Tahap 5 GridView',
      home: const GridViewPage(),
    );
  }
}

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  final List<Map<String, dynamic>> courses = const [
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
    {
      'code': 'FL004',
      'title': 'Navigation Flutter',
      'credits': 3,
      'status': 'Belum',
    },
    {
      'code': 'FL005',
      'title': 'User Interaction',
      'credits': 3,
      'status': 'Belum',
    },
    {
      'code': 'FL006',
      'title': 'Flutter Forms',
      'credits': 3,
      'status': 'Belum',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5 - GridView'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;

          if (constraints.maxWidth < 600) {
            crossAxisCount = 1;
          } else if (constraints.maxWidth < 840) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 3;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$studentId - $studentName',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                course['code'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                course['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'SKS: ${course['credits']}',
                              ),
                              Text(
                                'Status: ${course['status']}',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}