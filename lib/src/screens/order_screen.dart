import 'package:flutter/material.dart';
import 'package:food_app/src/widgets/order_cart.dart';
import 'package:food_app/src/widgets/total_container.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Food Cart",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: [
          OrderCart(),
          OrderCart(),
          OrderCart(),
          OrderCart(),
          OrderCart(),
        ],
      ),
      bottomNavigationBar: TotalContainer(),
    );
  }
}
