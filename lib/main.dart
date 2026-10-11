import 'package:flutter/material.dart';

const String studentName = 'I Ketut Alit Junaedi Wardana';
const String studentId = '2415051050';

void main() {
  runApp(const CourseExplorerApp());
}

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
    description:
        'Mempelajari dasar pembuatan antarmuka aplikasi menggunakan Flutter.',
  ),
  Course(
    code: 'FL002',
    title: 'Widget dan Layout Flutter',
    credits: 3,
    description:
        'Mempelajari widget, layout, dan penyusunan komponen antarmuka.',
  ),
  Course(
    code: 'FL003',
    title: 'State Management',
    credits: 3,
    description:
        'Mempelajari pengelolaan state dan pembaruan tampilan aplikasi.',
  ),
  Course(
    code: 'FL004',
    title: 'Navigasi Aplikasi',
    credits: 2,
    description:
        'Mempelajari perpindahan halaman dan pengiriman data antarscreen.',
  ),
  Course(
    code: 'FL005',
    title: 'Form dan Validasi',
    credits: 2,
    description:
        'Mempelajari input pengguna, validasi form, dan umpan balik aplikasi.',
  ),
  Course(
    code: 'FL006',
    title: 'Arsitektur Aplikasi',
    credits: 3,
    description:
        'Mempelajari pemisahan tanggung jawab dan struktur aplikasi.',
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

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    FeedbackPage(),
  ];

  final List<String> pageTitles = const [
    'Home',
    'Courses',
    'Feedback',
  ];

  @override
  Widget build(BuildContext context) {
    final bool useRail = MediaQuery.of(context).size.width >= 840;

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Explorer - ${pageTitles[selectedIndex]}'),
        centerTitle: false,
      ),
      body: Row(
        children: [
          if (useRail)
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
      bottomNavigationBar: useRail
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFavorite = false;

  // Tahap 4: ValueNotifier untuk satu nilai sederhana.
  final ValueNotifier<int> favoriteCount = ValueNotifier<int>(0);

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Memperbarui nilai yang diamati ValueListenableBuilder.
    favoriteCount.value = isFavorite ? 1 : 0;
  }

  @override
  void dispose() {
    favoriteCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Welcome to Course Explorer',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Jelajahi materi pembelajaran dan eksperimen state management.',
        ),
        const SizedBox(height: 16),
        const StudentIdentity(),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tahap 4: ValueNotifier',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tekan tombol hati untuk mengubah status favorit. '
                  'Angka di bawah akan diperbarui melalui '
                  'ValueListenableBuilder.',
                ),
                const SizedBox(height: 16),
                FavoriteDemoChild(
                  title: 'Komponen Favorit',
                  isFavorite: isFavorite,
                  onToggle: toggleFavorite,
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<int>(
                  valueListenable: favoriteCount,
                  builder: (context, value, child) {
                    return Card(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer,
                      child: ListTile(
                        leading: const Icon(Icons.favorite),
                        title: const Text('Jumlah Favorit Aktif'),
                        trailing: Text(
                          '$value',
                          style:
                              Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nilai berubah melalui favoriteCount.value, '
                  'tanpa memanggil setState() untuk memperbarui '
                  'angka yang diamati.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ringkasan Course Explorer',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('Total materi: ${courseList.length}'),
                const Text('Layout responsif dan navigasi tetap tersedia.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FavoriteDemoChild extends StatelessWidget {
  final String title;
  final bool isFavorite;
  final VoidCallback onToggle;

  const FavoriteDemoChild({
    super.key,
    required this.title,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          isFavorite ? 'Status: Favorit aktif' : 'Status: Belum favorit',
        ),
        trailing: IconButton(
          tooltip: isFavorite
              ? 'Hapus dari favorit'
              : 'Tambahkan ke favorit',
          onPressed: onToggle,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
        ),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columnCount = constraints.maxWidth >= 1000
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courseList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: columnCount == 1 ? 2.0 : 1.35,
          ),
          itemBuilder: (context, index) {
            return CourseCard(course: courseList[index]);
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => CourseDetailPage(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.menu_book, size: 32),
              const SizedBox(height: 8),
              Text(
                course.code,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                course.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text('${course.credits} SKS'),
              const SizedBox(height: 4),
              const Text('Tekan untuk melihat detail'),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Materi')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const StudentIdentity(),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.code,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text('Jumlah SKS: ${course.credits}'),
                  const SizedBox(height: 12),
                  Text(course.description),
                ],
              ),
            ),
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Feedback Terkirim'),
          content: Text(
            'Terima kasih, ${nameController.text.trim()}. '
            'Feedback kamu berhasil divalidasi.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Feedback',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const StudentIdentity(),
        const SizedBox(height: 16),
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: feedbackController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Masukkan feedback',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment_outlined),
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
                child: FilledButton.icon(
                  onPressed: submitFeedback,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Feedback'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}