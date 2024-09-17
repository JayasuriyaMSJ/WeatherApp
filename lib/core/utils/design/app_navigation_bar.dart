import 'package:flutter/material.dart';
import 'package:intern_weather/core/utils/design/lottie_anime.dart';
import 'package:intern_weather/features/Weather/presentation/screen/Explorer_page/explore_forecast.dart';
import 'package:intern_weather/features/Weather/presentation/screen/Search/search_u_i.dart';
import 'package:intern_weather/features/Weather/presentation/screen/WeatherUI/weather_u_i.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  _AppNavigationBarState createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;

  // Lazy-loaded page views
  final List<Widget> _pages = [
    const WeatherUI(),
    const ExploreForecast(),
    const SearchUI(),
    const UserAccountPage(),
  ];

  // Handle navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.blue, // Color of the selected icon
            unselectedItemColor: Colors.grey, // Color of the unselected icons
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_outlined),
                label: 'Weather',
                activeIcon: Icon(Icons.cloud), // Different icon when selected
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: 'Explore',
                activeIcon: Icon(Icons.explore),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: 'Search',
                activeIcon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Account',
                activeIcon: Icon(Icons.person),
              ),
            ],
            showUnselectedLabels: false, // Hide unselected labels
          ),
        ),
      ),
    );
  }

  // Build the selected page
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const WeatherUI();
      case 1:
        return const ExploreForecast();
      case 2:
        return const SearchUI();
      case 3:
        return const UserAccountPage();
      default:
        return const WeatherUI();
    }
  }
}

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LottieAnimation(
              fileName: "assets/gif/Animation - 1726585746003.json",
              play: true,
              continuousPlay: true,
              wid: 300,
              hei: 300),
          const SizedBox(
            height: 50,
          ),
          RichText(
            text: TextSpan(
              text: "Under Construction\n  We be Back Soon",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
          ),
        ],
      ),
    );
  }
}
