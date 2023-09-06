import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchit/repos/home/home_repository.dart';
import 'package:watchit/view/downloads/downloads_screen.dart';
import 'package:watchit/view/home/home_screen.dart';
import 'package:watchit/view/new_and_hot/new_and_hot_screen.dart';
import 'package:watchit/view/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget currentScreen = RepositoryProvider(
    create: (context) => HomeRepository(),
    child: const HomeScreen(),
  );

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        {
          currentScreen = RepositoryProvider(
            create: (context) => HomeRepository(),
            child: const HomeScreen(),
          );
        }
        break;
      case 1:
        {
          currentScreen = const NewAndHotScreen();
        }
        break;
      case 2:
        {
          currentScreen = const SearchScreen();
        }
        break;

      case 3:
        {
          currentScreen = const DownloadsScreen();
        }
        break;
    }
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        type: const BottomNavigationBarThemeData().type,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        unselectedItemColor:
            const BottomNavigationBarThemeData().unselectedItemColor,
        selectedItemColor:
            const BottomNavigationBarThemeData().unselectedItemColor,
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        items: const [
          BottomNavigationBarItem(
              label: 'Home',
              icon: ImageIcon(
                AssetImage('assets/home.png'),
              )),
          BottomNavigationBarItem(
              label: 'New & Hot',
              icon: ImageIcon(
                AssetImage('assets/new_and_hot.png'),
              )),
          BottomNavigationBarItem(
              label: 'Search',
              icon: ImageIcon(
                AssetImage('assets/search.png'),
              )),
          BottomNavigationBarItem(
              label: 'Downloads',
              icon: ImageIcon(
                AssetImage('assets/downloads.png'),
              )),
        ],
      ),
    );
  }
}
