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
      title: 'Tahap 2 MediaQuery',
      home: const MediaQueryPage(),
    );
  }
}

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    final orientation = MediaQuery.of(context).orientation;

    final deviceCategory = width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2 - MediaQuery'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Informasi Layar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text('Lebar: ${width.toStringAsFixed(0)} px'),
              Text('Tinggi: ${height.toStringAsFixed(0)} px'),
              Text('Orientasi: $orientation'),
              Text('Kategori: $deviceCategory'),
              const SizedBox(height: 20),
              Text(
                '$studentId - $studentName',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}