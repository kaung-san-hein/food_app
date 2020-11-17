import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/widgets/small_button.dart';

class FoodItemCard extends StatelessWidget {
  final FoodModel foodModel;

  FoodItemCard({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(0, 3.0),
            color: Colors.black38,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/breakfast.jpeg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${foodModel.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Container(
                width: 200.0,
                child: Text("${foodModel.description}"),
              ),
              Container(
                width: 200.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\u20B5 ${foodModel.price}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SmallButton(btnText: "Buy"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
