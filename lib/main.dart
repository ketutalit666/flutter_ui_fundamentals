import 'package:flutter/material.dart';

const String studentName = 'I Ketut Alit Junaedi Wardana';
const String studentId = '2415051050';

class Course {
  final String code;
  final String title;
  final int credits;
  final String description;

  const Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.description,
  });
}

const List<Course> courseList = [
  Course(
    code: 'FL001',
    title: 'Flutter UI Fundamentals',
    credits: 3,
    description: 'Mengenal dasar Flutter, widget, dan pembuatan antarmuka.',
  ),
  Course(
    code: 'FL002',
    title: 'Widget dan Layout Flutter',
    credits: 3,
    description: 'Mempelajari layout, responsive UI, dan komposisi widget.',
  ),
  Course(
    code: 'FL003',
    title: 'State Management',
    credits: 3,
    description: 'Mengelola state menggunakan setState dan ChangeNotifier.',
  ),
  Course(
    code: 'FL004',
    title: 'Navigasi Aplikasi',
    credits: 2,
    description: 'Mempelajari perpindahan halaman dan pengiriman data.',
  ),
  Course(
    code: 'FL005',
    title: 'Form dan Validasi',
    credits: 2,
    description: 'Membuat formulir dan memvalidasi input pengguna.',
  ),
  Course(
    code: 'FL006',
    title: 'Arsitektur Aplikasi',
    credits: 3,
    description: 'Memahami pemisahan tanggung jawab dalam aplikasi.',
  ),
];

/// Tahap 5: state dan logika favorit dipisahkan dari UI.
class CourseState extends ChangeNotifier {
  final Set<String> favorites = {};

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    // Memberi tahu widget listener bahwa state telah berubah.
    notifyListeners();
  }

  bool isFavorite(String id) {
    return favorites.contains(id);
  }

  int get favoriteCount => favorites.length;
}

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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

  // Satu object state dipakai bersama oleh halaman terkait.
  final CourseState courseState = CourseState();

  @override
  void dispose() {
    courseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(courseState: courseState),
      CoursesPage(courseState: courseState),
      const FeedbackPage(),
    ];

    const pageTitles = ['Home', 'Courses', 'Feedback'];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: Text(pageTitles[selectedIndex]),
            centerTitle: false,
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
      },
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
        title: const Text(
          studentName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('NIM: $studentId'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final CourseState courseState;

  const HomePage({
    super.key,
    required this.courseState,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Course Explorer',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Jelajahi materi pembelajaran dan simpan materi favorit.',
        ),
        const SizedBox(height: 12),
        const StudentIdentity(),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tahap 5: ChangeNotifier',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'CourseState menyimpan data favorit. '
                  'notifyListeners() memberi tahu widget ketika data berubah.',
                ),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: courseState,
                  builder: (context, child) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Jumlah favorit: ${courseState.favoriteCount}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  'Coba tekan tombol hati pada salah satu materi di halaman Courses.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Materi Pilihan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ...courseList.take(3).map(
          (course) => CourseFavoriteTile(
            course: course,
            courseState: courseState,
          ),
        ),
      ],
    );
  }
}

class CoursesPage extends StatelessWidget {
  final CourseState courseState;

  const CoursesPage({
    super.key,
    required this.courseState,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1000 ? 3 : width >= 600 ? 2 : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courseList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 190,
          ),
          itemBuilder: (context, index) {
            final course = courseList[index];

            return CourseCard(
              course: course,
              courseState: courseState,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailPage(
                      course: course,
                      courseState: courseState,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final CourseState courseState;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.courseState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.code,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 6),
            Expanded(
              child: InkWell(
                onTap: onTap,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    course.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            Text('${course.credits} SKS'),
            const SizedBox(height: 4),
            AnimatedBuilder(
              animation: courseState,
              builder: (context, child) {
                final favorite = courseState.isFavorite(course.code);

                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        favorite ? 'Favorit' : 'Belum favorit',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    IconButton(
                      tooltip: favorite
                          ? 'Hapus dari favorit'
                          : 'Tambahkan ke favorit',
                      onPressed: () {
                        courseState.toggleFavorite(course.code);
                      },
                      icon: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        color: favorite ? Colors.red : null,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CourseFavoriteTile extends StatelessWidget {
  final Course course;
  final CourseState courseState;

  const CourseFavoriteTile({
    super.key,
    required this.course,
    required this.courseState,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AnimatedBuilder(
        animation: courseState,
        builder: (context, child) {
          final favorite = courseState.isFavorite(course.code);

          return ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(course.title),
            subtitle: Text('${course.code} • ${course.credits} SKS'),
            trailing: IconButton(
              tooltip: favorite ? 'Hapus favorit' : 'Jadikan favorit',
              onPressed: () {
                courseState.toggleFavorite(course.code);
              },
              icon: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: favorite ? Colors.red : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;
  final CourseState courseState;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.courseState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.code)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const StudentIdentity(),
          const SizedBox(height: 16),
          Text(
            course.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('${course.credits} SKS'),
          const SizedBox(height: 16),
          Text(course.description),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: courseState,
            builder: (context, child) {
              final favorite = courseState.isFavorite(course.code);

              return FilledButton.icon(
                onPressed: () {
                  courseState.toggleFavorite(course.code);
                },
                icon: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  favorite ? 'Hapus dari Favorit' : 'Tambahkan ke Favorit',
                ),
              );
            },
          ),
        ],
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Feedback Terkirim'),
          content: Text(
            'Terima kasih, ${_nameController.text.trim()}! '
            'Feedback Anda berhasil dicatat.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const StudentIdentity(),
        const SizedBox(height: 16),
        Text(
          'Feedback',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Masukkan feedback',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Feedback wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitFeedback,
                  child: const Text('Kirim Feedback'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
