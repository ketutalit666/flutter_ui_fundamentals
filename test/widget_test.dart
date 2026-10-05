import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/main.dart';

void main() {
  testWidgets(
    'Course Explorer menampilkan halaman Home',
    (WidgetTester tester) async {
      // Menjalankan aplikasi
      await tester.pumpWidget(const CourseExplorerApp());

      // Memastikan judul aplikasi tampil
      expect(find.text('Course Explorer'), findsOneWidget);

      // Home muncul pada AppBar dan NavigationBar,
      // sehingga menggunakan findsWidgets.
      expect(find.text('Home'), findsWidgets);

      // Memastikan identitas mahasiswa tampil
      expect(
        find.text('I Ketut Alit Junaedi Wardana'),
        findsOneWidget,
      );

      expect(
        find.text('NIM: 2415051050'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'NavigationBar dapat berpindah ke halaman Courses',
    (WidgetTester tester) async {
      // Menjalankan aplikasi
      await tester.pumpWidget(const CourseExplorerApp());

      // Tekan menu Courses pada NavigationBar
      await tester.tap(find.text('Courses').last);
      await tester.pumpAndSettle();

      // Memastikan halaman Courses tampil
      expect(find.text('Courses'), findsWidgets);

      // Memastikan course tampil
      expect(
        find.text('Flutter UI Fundamentals'),
        findsOneWidget,
      );

      expect(
        find.text('Widget dan Layout Flutter'),
        findsOneWidget,
      );

      expect(
        find.text('Responsive Layout'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'NavigationBar dapat berpindah ke halaman Profile',
    (WidgetTester tester) async {
      // Menjalankan aplikasi
      await tester.pumpWidget(const CourseExplorerApp());

      // Tekan menu Profile
      await tester.tap(find.text('Profile').last);
      await tester.pumpAndSettle();

      // Memastikan halaman Profile tampil
      expect(find.text('Profile'), findsWidgets);

      // Memastikan identitas mahasiswa tampil
      expect(
        find.text('I Ketut Alit Junaedi Wardana'),
        findsOneWidget,
      );

      expect(
        find.text('NIM: 2415051050'),
        findsOneWidget,
      );
    },
  );
}