import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/widgets/button.dart';

class FoodDetailScreen extends StatelessWidget {
  final FoodModel foodModel;

  FoodDetailScreen({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Food Details",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Image.asset(
                  "assets/images/lunch.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${foodModel.name}",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\u20b5 ${foodModel.price}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text("Description"),
              SizedBox(height: 10.0),
              Text(
                "${foodModel.description}",
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.add_circle), onPressed: null),
                  SizedBox(width: 15.0),
                  Text(
                    "1",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 15.0),
                  IconButton(icon: Icon(Icons.remove_circle), onPressed: null),
                ],
              ),
              SizedBox(height: 15.0),
              Button(btnText: "Add To Cart"),
            ],
          ),
        ),
      ),
    );
  }
}
