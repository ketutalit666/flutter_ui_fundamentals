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
      title: 'Tahap 4 Expanded Flexible Wrap',
      home: const LayoutPage(),
    );
  }
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4 - Layout'),
      ),
      body: SingleChildScrollView(
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

            const SizedBox(height: 24),

            const Text(
              'Expanded 2 : 1',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          'Expanded 2',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Expanded 1',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Flexible',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.orange,
                    child: const Text(
                      'Flexible menyesuaikan ruang yang tersedia.',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.phone_android),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Wrap - 6 Chip',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('UI')),
                Chip(label: Text('Layout')),
                Chip(label: Text('Responsive')),
                Chip(label: Text('Mobile')),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Identitas Mahasiswa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text('Nama: $studentName'),
            Text('NIM: $studentId'),
          ],
        ),
      ),
    );
  }
}