import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';

class BoughtFoods extends StatefulWidget {
  final FoodModel food;

  BoughtFoods(this.food);

  @override
  _BoughtFoodsState createState() => _BoughtFoodsState();
}

class _BoughtFoodsState extends State<BoughtFoods> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Container(
              height: 200.0,
              width: 340.0,
              child: Image.asset(
                "assets/images/breakfast.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 60.0,
                width: 340.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black12,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              right: 10.0,
              bottom: 5.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 16.0),
                          Icon(Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 16.0),
                          Icon(Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 16.0),
                          Icon(Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 16.0),
                          Icon(Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 16.0),
                          SizedBox(width: 20.0),
                          Text(
                            "(Reviews)",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.food.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "Min Order",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
