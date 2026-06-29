import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:super_manager/components/nav_bar.dart';
import 'package:super_manager/components/bottom_nav_bar.dart';
import 'package:super_manager/pages/shopping_screen.dart';
import 'package:super_manager/pages/store_search_screen.dart';
import 'package:super_manager/pages/category_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'super-manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ShoppingScreen(),
    StoreSearchScreen(),
    CategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            backgroundColor: Colors.lightGreen[200],
            body: Row(
              children: [
                NavRail(
                  index: _selectedIndex,
                  onDestinationSelected: (i) =>
                      setState(() => _selectedIndex = i),
                ),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.lightGreen[200],
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavBar(
              index: _selectedIndex,
              onSelected: (i) => setState(() => _selectedIndex = i),
            ),
          );
        }
      },
    );
  }
}
