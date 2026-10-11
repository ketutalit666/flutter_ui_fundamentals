import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/course.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';

const String studentName = 'I Ketut Alit Junaedi Wardana';
const String studentId = '2415051050';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState()..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseState extends ChangeNotifier {
  final CourseRepository _repository = CourseRepository(CourseService());

  List<Course> courses = [];
  final Set<String> favorites = {};

  Future<void> loadCourses() async {
    try {
      courses = await _repository.getCourses();
      notifyListeners();
    } catch (error) {
      debugPrint('Gagal memuat data course: $error');
    }
  }

  bool isFavorite(String code) => favorites.contains(code);

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }
    notifyListeners();
  }
}

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

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    FeedbackPage(),
  ];

  final List<String> titles = const [
    'Home',
    'Courses',
    'Feedback',
  ];

  @override
  Widget build(BuildContext context) {
    final favoriteCount = context.watch<CourseState>().favorites.length;
    final isWide = MediaQuery.sizeOf(context).width >= 840;

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Badge(
                label: Text('$favoriteCount'),
                child: const Icon(Icons.favorite),
              ),
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
                setState(() => selectedIndex = index);
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
                setState(() => selectedIndex = index);
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
  }
}

class StudentIdentity extends StatelessWidget {
  const StudentIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text('NIM: $studentId'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Course Explorer',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Jelajahi materi pembelajaran dan tandai course favoritmu.',
        ),
        const SizedBox(height: 16),
        const StudentIdentity(),
        const SizedBox(height: 16),
        Text(
          'Daftar Materi',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        if (state.courses.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else
          ...state.courses.take(3).map(
                (course) => CourseCard(course: course),
              ),
      ],
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const StudentIdentity(),
        const SizedBox(height: 16),
        Text(
          'Semua Materi',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        if (state.courses.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          )
        else
          ...state.courses.map(
            (course) => CourseCard(course: course),
          ),
      ],
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
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: Icon(Icons.menu_book),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.code,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('${course.credits} SKS'),
                  const SizedBox(height: 4),
                  Text(course.status),
                ],
              ),
            ),
            Consumer<CourseState>(
              builder: (context, state, child) {
                final favorite = state.isFavorite(course.code);

                return IconButton(
                  tooltip: favorite
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  onPressed: () {
                    context
                        .read<CourseState>()
                        .toggleFavorite(course.code);
                  },
                  icon: Icon(
                    favorite ? Icons.favorite : Icons.favorite_border,
                    color: favorite ? Colors.red : null,
                  ),
                );
              },
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
    final feedback = feedbackController.text.trim();

    if (feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback tidak boleh kosong.'),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Feedback Terkirim'),
          content: Text('Terima kasih atas masukan: $feedback'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    feedbackController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const StudentIdentity(),
        const SizedBox(height: 16),
        Text(
          'Berikan Feedback',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: feedbackController,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Tulis masukan untuk aplikasi...',
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: submitFeedback,
          icon: const Icon(Icons.send),
          label: const Text('Kirim Feedback'),
        ),
      ],
    );
  }
}