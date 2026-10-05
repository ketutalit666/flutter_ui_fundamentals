import 'package:flutter/material.dart';

const String studentName = 'I Ketut Alit Junaedi Wardana';
const String studentId = '2415051050';

void main() {
  runApp(const DebuggingLabApp());
}

class DebuggingLabApp extends StatelessWidget {
  const DebuggingLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Debugging Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DebuggingPage(),
    );
  }
}

class DebuggingPage extends StatelessWidget {
  const DebuggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 16 - Debugging'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IDENTITAS
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('NIM: $studentId'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Debugging & Troubleshooting',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            const Text(
              'Empat contoh masalah umum Flutter dan cara mengatasinya.',
            ),

            const SizedBox(height: 20),

            // =================================================
            // 1. RENDERFLEX OVERFLOW
            // =================================================

            const DebugSection(
              number: '1',
              title: 'RenderFlex Overflow',
              description:
                  'Masalah terjadi ketika widget dalam Row melebihi ruang yang tersedia.',
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'Widget A\nExpanded flex 2',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'Widget B\nExpanded flex 1',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Solusi: gunakan Expanded/Flexible agar widget membagi ruang yang tersedia.',
            ),

            const Divider(height: 40),

            // =================================================
            // 2. UNBOUNDED LISTVIEW
            // =================================================

            const DebugSection(
              number: '2',
              title: 'Unbounded ListView',
              description:
                  'ListView di dalam Column membutuhkan batas tinggi.',
            ),

            const SizedBox(height: 10),

            Container(
              height: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: Column(
                children: [
                  const Text(
                    'Daftar Course',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.book),
                          title: Text('Flutter UI Fundamentals'),
                        ),
                        ListTile(
                          leading: Icon(Icons.book),
                          title: Text('Responsive Layout'),
                        ),
                        ListTile(
                          leading: Icon(Icons.book),
                          title: Text('Navigation Flutter'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Solusi: gunakan Expanded agar ListView mendapatkan batas tinggi.',
            ),

            const Divider(height: 40),

            // =================================================
            // 3. KEYBOARD OVERFLOW
            // =================================================

            const DebugSection(
              number: '3',
              title: 'Keyboard Overflow',
              description:
                  'Form menggunakan SingleChildScrollView agar dapat digulir saat keyboard muncul.',
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: const KeyboardForm(),
            ),

            const Divider(height: 40),

            // =================================================
            // 4. DUPLICATE NAVIGATION
            // =================================================

            const DebugSection(
              number: '4',
              title: 'Duplicate Navigation',
              description:
                  'Pastikan satu tombol hanya menjalankan satu Navigator.push().',
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationTestPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.navigation),
                label: const Text('Test Navigation'),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Tombol di atas hanya memanggil Navigator.push() satu kali.',
            ),

            const SizedBox(height: 30),

            // =================================================
            // KESIMPULAN
            // =================================================

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kesimpulan Debugging',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '• RenderFlex Overflow → gunakan Expanded/Flexible/Wrap.\n'
                      '• Unbounded ListView → gunakan Expanded atau batas ukuran.\n'
                      '• Keyboard Overflow → gunakan SingleChildScrollView.\n'
                      '• Duplicate Navigation → pastikan Navigator.push() tidak dipanggil dua kali.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// DEBUG SECTION
// =====================================================

class DebugSection extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const DebugSection({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          child: Text(number),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 4),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// KEYBOARD FORM
// =====================================================

class KeyboardForm extends StatefulWidget {
  const KeyboardForm({super.key});

  @override
  State<KeyboardForm> createState() => _KeyboardFormState();
}

class _KeyboardFormState extends State<KeyboardForm> {
  final nameController = TextEditingController();
  final commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: commentController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Komentar',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Form berhasil diuji.'),
                  ),
                );
              },
              child: const Text('Kirim'),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// NAVIGATION TEST PAGE
// =====================================================

class NavigationTestPage extends StatelessWidget {
  const NavigationTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 70,
            ),
            const SizedBox(height: 16),
            const Text(
              'Navigation berhasil.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}