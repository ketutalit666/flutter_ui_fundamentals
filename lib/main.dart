import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String studentName = 'I Ketut Alit Junaedi Wardana';
const String studentId = '2415051050';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseState extends ChangeNotifier {
  final Set<String> _favorites = {};

  bool isFavorite(String code) => _favorites.contains(code);

  int get favoriteCount => _favorites.length;

  void toggleFavorite(String code) {
    if (_favorites.contains(code)) {
      _favorites.remove(code);
    } else {
      _favorites.add(code);
    }

    notifyListeners();
  }
}

class Course {
  final String code;
  final String title;
  final int credits;
  final String status;

  const Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
  });
}

const List<Course> courses = [
  Course(
    code: 'FL001',
    title: 'Flutter UI Fundamentals',
    credits: 3,
    status: 'Selesai',
  ),
  Course(
    code: 'FL002',
    title: 'Widget dan Layout Flutter',
    credits: 3,
    status: 'Sedang Dipelajari',
  ),
  Course(
    code: 'FL003',
    title: 'State Management',
    credits: 3,
    status: 'Belum Dipelajari',
  ),
  Course(
    code: 'FL004',
    title: 'Navigasi Aplikasi',
    credits: 2,
    status: 'Belum Dipelajari',
  ),
  Course(
    code: 'FL005',
    title: 'Form dan Validasi',
    credits: 2,
    status: 'Belum Dipelajari',
  ),
  Course(
    code: 'FL006',
    title: 'Arsitektur Aplikasi',
    credits: 3,
    status: 'Belum Dipelajari',
  ),
];

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // watch() mendengarkan perubahan CourseState.
    final provider = context.watch<CourseState>();

    final pages = [
      HomePage(
        onOpenCourses: () {
          setState(() {
            selectedIndex = 1;
          });
        },
      ),
      const CoursesPage(),
      const FeedbackPage(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Course Explorer'),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.favorite),
                    const SizedBox(width: 6),
                    Text('${provider.favoriteCount}'),
                  ],
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              if (isWide)
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
                      icon: Icon(Icons.feedback_outlined),
                      selectedIcon: Icon(Icons.feedback),
                      label: Text('Feedback'),
                    ),
                  ],
                ),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: pages,
                ),
              ),
            ],
          ),
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
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
                      icon: Icon(Icons.feedback_outlined),
                      selectedIcon: Icon(Icons.feedback),
                      label: 'Feedback',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onOpenCourses;

  const HomePage({
    super.key,
    required this.onOpenCourses,
  });

  @override
  Widget build(BuildContext context) {
    // watch() membuat HomePage mendengarkan perubahan jumlah favorit.
    final provider = context.watch<CourseState>();

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const StudentIdentity(),
        const SizedBox(height: 24),
        Text(
          'Selamat Datang!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Jelajahi materi pembelajaran Flutter dan pantau '
          'materi favorit Anda.',
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  size: 36,
                  color: Colors.red,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Jumlah Materi Favorit'),
                      Text(
                        '${provider.favoriteCount} materi',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: onOpenCourses,
          icon: const Icon(Icons.menu_book),
          label: const Text('Lihat Semua Materi'),
        ),
        const SizedBox(height: 24),
        const Text(
          'Materi Unggulan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        CourseCard(course: courses[0]),
        CourseCard(course: courses[1]),
      ],
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 1000
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 190,
          ),
          itemBuilder: (context, index) {
            return CourseCard(course: courses[index]);
          },
        );
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    course.code,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),

                // Consumer membatasi rebuild pada bagian tombol favorit.
                Consumer<CourseState>(
                  builder: (context, provider, child) {
                    final isFavorite =
                        provider.isFavorite(course.code);

                    return IconButton(
                      tooltip: isFavorite
                          ? 'Hapus dari favorit'
                          : 'Tambahkan ke favorit',
                      onPressed: () {
                        // read() hanya mengambil object untuk menjalankan aksi.
                        context
                            .read<CourseState>()
                            .toggleFavorite(course.code);
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                    );
                  },
                ),
              ],
            ),
            Text(
              course.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Text('${course.credits} SKS'),
            const SizedBox(height: 4),
            Text(
              course.status,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController =
      TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    if (feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan feedback terlebih dahulu.'),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feedback Terkirim'),
        content: Text(feedbackController.text.trim()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );

    feedbackController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const StudentIdentity(),
        const SizedBox(height: 24),
        Text(
          'Feedback',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: feedbackController,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Tulis feedback',
            hintText: 'Masukkan saran atau pendapat Anda',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: submitFeedback,
          child: const Text('Kirim Feedback'),
        ),
      ],
    );
  }
}

class StudentIdentity extends StatelessWidget {
  const StudentIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: const Text(studentName),
        subtitle: const Text('NIM: $studentId'),
      ),
    );
  }
}
