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
      body: const Center(
        child: StudentInfo(
          title: 'Profile',
        ),
      ),
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

class CourseCard extends StatefulWidget {
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
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${widget.title} ditambahkan ke favorit'
              : '${widget.title} dihapus dari favorit',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void showLongPressMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Long Press'),
          content: Text(
            'Kamu menekan lama course "${widget.title}".',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: showLongPressMessage,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                child: Text(
                  widget.code.substring(2),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Kode: ${widget.code}'),
                    Text('Status: ${widget.status}'),
                  ],
                ),
              ),

              IconButton(
                onPressed: toggleFavorite,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                tooltip: 'Favorit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}