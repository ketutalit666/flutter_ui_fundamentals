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
      title: 'Tahap 3 LayoutBuilder',
      home: const LayoutBuilderPage(),
    );
  }
}

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3 - LayoutBuilder'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          String category;
          String description;
          IconData icon;

          if (width < 600) {
            category = 'Compact';
            description = 'Tampilan untuk layar kecil';
            icon = Icons.smartphone;
          } else if (width < 840) {
            category = 'Medium';
            description = 'Tampilan untuk layar menengah';
            icon = Icons.tablet;
          } else {
            category = 'Expanded';
            description = 'Tampilan untuk layar lebar';
            icon = Icons.desktop_windows;
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(description),
                  const SizedBox(height: 20),
                  Text(
                    'Lebar tersedia: ${width.toStringAsFixed(0)} px',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$studentId - $studentName',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}