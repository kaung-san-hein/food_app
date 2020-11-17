import 'package:flutter/material.dart';
import 'package:food_app/src/admin/screens/add_food_screen.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/screens/explore_screen.dart';
import 'package:food_app/src/screens/home_screen.dart';
import 'package:food_app/src/screens/order_screen.dart';
import 'package:food_app/src/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final MainModel mainModel;

  MainScreen({this.mainModel});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTabIndex = 0;
  List<Widget> _pages;
  Widget _currentPage;

  HomeScreen _homeScreen;
  OrderScreen _orderScreen;
  ExploreScreen _favoriteScreen;
  ProfileScreen _profileScreen;

  @override
  void initState() {
    widget.mainModel.fetchFood();

    _homeScreen = HomeScreen();
    _orderScreen = OrderScreen();
    _favoriteScreen = ExploreScreen();
    _profileScreen = ProfileScreen();
    _pages = [_homeScreen, _favoriteScreen, _orderScreen, _profileScreen];
    _currentPage = _homeScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            _currentTabIndex == 0
                ? "Food App"
                : _currentTabIndex == 1
                    ? "All Food Items"
                    : _currentTabIndex == 2
                        ? "Orders"
                        : "Profile",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: _buildShoppingCart(),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddFoodScreen(),
                    ),
                  );
                },
                leading: Icon(Icons.list),
                title: Text(
                  "Add Food Item",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
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
              icon: Icon(Icons.explore),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
        body: _currentPage,
      ),
    );
  }

  Widget _buildShoppingCart() {
    return Stack(
      children: [
        Icon(
          Icons.shopping_cart,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
