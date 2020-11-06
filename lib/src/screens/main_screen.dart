import 'package:flutter/material.dart';
import 'package:food_app/src/screens/favorite_screen.dart';
import 'package:food_app/src/screens/home_screen.dart';
import 'package:food_app/src/screens/order_screen.dart';
import 'package:food_app/src/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTabIndex = 0;
  List<Widget> _pages;
  Widget _currentPage;

  HomeScreen _homeScreen;
  OrderScreen _orderScreen;
  FavoriteScreen _favoriteScreen;
  ProfileScreen _profileScreen;

  @override
  void initState() {
    _homeScreen = HomeScreen();
    _orderScreen = OrderScreen();
    _favoriteScreen = FavoriteScreen();
    _profileScreen = ProfileScreen();
    _pages = [_homeScreen, _orderScreen, _favoriteScreen, _profileScreen];
    _currentPage = _homeScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
            _currentPage = _pages[index];
          });
        },
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: _currentPage,
    );
  }
}
