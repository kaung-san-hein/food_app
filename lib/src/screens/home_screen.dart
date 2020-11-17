import 'package:flutter/material.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/screens/food_detail_screen.dart';
import 'package:food_app/src/widgets/bought_foods.dart';
import 'package:food_app/src/widgets/food_category.dart';
import 'package:food_app/src/widgets/home_top_info.dart';
import 'package:food_app/src/widgets/search_field.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: [
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(height: 20.0),
          SearchField(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frequently Bought Foods",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return Column(
                children: model.foods.map((food) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              FoodDetailScreen(foodModel: food),
                        ),
                      );
                    },
                    child: BoughtFoods(food),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
