import 'package:red_cross_news_app/pages/donate/donate_page.dart';
import 'package:red_cross_news_app/pages/shops/shops_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShopsPage(),
    const DonatePage(),
    // const HomePage(),
    // const GaragesPage(),
    // const DtcPage(),
    // const TrainingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: _selectedIndex == 0
                ? Icon(Icons.home,
                    size: 30, color: Colors.white) // Selected state
                : Icon(Icons.home_outlined,
                    size: 30, color: Colors.white), // Unselected state
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   label: "Donate",
          //   icon: _selectedIndex == 1
          //       ? Icon(Icons.volunteer_activism,
          //           size: 30, color: Colors.white) // Selected state
          //       : Icon(Icons.volunteer_activism_outlined,
          //           size: 30, color: Colors.white), // Unselected state
          //   backgroundColor: Colors.white,
          // ),

          // BottomNavigationBarItem(
          //   label: "Home",
          //   icon: _selectedIndex == 0
          //       ? Image.asset(
          //           'lib/assets/icons/home.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         )
          //       : Image.asset(
          //           'lib/assets/icons/home_outline.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         ),
          //   backgroundColor: Colors.white,
          // ),
          BottomNavigationBarItem(
            label: "Donate",
            icon: _selectedIndex == 1
                ? Image.asset(
                    'lib/assets/icons/donate_icon.png',
                    width: 65,
                    height: 30,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    'lib/assets/icons/donate_icon.png',
                    width: 65,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   label: "Shop",
          //   icon: _selectedIndex == 1
          //       ? Image.asset(
          //           'lib/assets/icons/shop.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         )
          //       : Image.asset(
          //           'lib/assets/icons/shop_outline.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         ),
          //   backgroundColor: Colors.white,
          // ),
          // BottomNavigationBarItem(
          //   label: "Garage",
          //   icon: _selectedIndex == 2
          //       ? Image.asset(
          //           'lib/assets/icons/garage.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         )
          //       : Image.asset(
          //           'lib/assets/icons/garage_outline.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         ),
          //   backgroundColor: Colors.white,
          // ),
          // BottomNavigationBarItem(
          //   label: "DTC",
          //   icon: _selectedIndex == 3
          //       ? Image.asset(
          //           'lib/assets/icons/dtc.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         )
          //       : Image.asset(
          //           'lib/assets/icons/dtc_outline.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         ),
          //   backgroundColor: Colors.white,
          // ),
          // BottomNavigationBarItem(
          //   label: "Trainings",
          //   icon: _selectedIndex == 4
          //       ? Image.asset(
          //           'lib/assets/icons/training.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         )
          //       : Image.asset(
          //           'lib/assets/icons/training_outline.png',
          //           width: 30,
          //           height: 30,
          //           fit: BoxFit.contain,
          //         ),
          //   backgroundColor: Colors.white,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade200,
        onTap: _onItemTapped,
      ),
    );
  }
}
