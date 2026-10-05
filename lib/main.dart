import 'package:flutter/material.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

// ==================== MAIN PAGE ====================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    ProfilePage(),
  ];

  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.menu_book_outlined),
      selectedIcon: Icon(Icons.menu_book),
      label: 'Courses',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Expanded menggunakan NavigationRail
        if (width >= 840) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: pages[selectedIndex],
                ),
              ],
            ),
          );
        }

        // Compact dan Medium menggunakan NavigationBar
        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: destinations,
          ),
        );
      },
    );
  }
}

// ==================== HOME ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: const Center(
        child: StudentInfo(
          title: 'Home',
        ),
      ),
    );
  }
}

// ==================== COURSES ====================

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CourseCard(
            code: 'FL001',
            title: 'Flutter UI Fundamentals',
            status: 'Selesai',
          ),
          CourseCard(
            code: 'FL002',
            title: 'Widget dan Layout Flutter',
            status: 'Berjalan',
          ),
          CourseCard(
            code: 'FL003',
            title: 'Responsive Layout',
            status: 'Berjalan',
          ),
        ],
      ),
    );
  }
}

// ==================== PROFILE ====================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const FeedbackForm(),
    );
  }
}

// ==================== STUDENT INFO ====================

class StudentInfo extends StatelessWidget {
  final String title;

  const StudentInfo({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              'I Ketut Alit Junaedi Wardana',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const Text('NIM: 2415051050'),
          ],
        ),
      ),
    );
  }
}

// ==================== COURSE CARD ====================

class CourseCard extends StatelessWidget {
  final String code;
  final String title;
  final String status;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            code.substring(2),
          ),
        ),
        title: Text(title),
        subtitle: Text(
          'Kode: $code\nStatus: $status',
        ),
        isThreeLine: true,
      ),
    );
  }
}

// ==================== FEEDBACK FORM ====================

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController nimController =
      TextEditingController();

  final TextEditingController commentController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form berhasil dikirim.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feedback Course',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            const Text(
              'Silakan isi data dan komentar Anda.',
            ),

            const SizedBox(height: 20),

            // Nama
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            // NIM
            TextFormField(
              controller: nimController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'NIM wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            // Komentar
            TextFormField(
              controller: commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Komentar',
                hintText: 'Masukkan komentar minimal 5 karakter',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.comment),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Komentar wajib diisi';
                }

                if (value.trim().length < 5) {
                  return 'Komentar minimal 5 karakter';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: submitForm,
                icon: const Icon(Icons.send),
                label: const Text('Kirim Feedback'),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Nama: I Ketut Alit Junaedi Wardana\n'
              'NIM: 2415051050',
            ),
          ],
        ),
      ),
    );
  }
}