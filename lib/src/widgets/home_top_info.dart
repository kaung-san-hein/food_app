import 'package:flutter/material.dart';
import 'package:food_app/src/constants/home_screen_title.dart';

class HomeTopInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What would ",
                style: kHomeScreenTitle,
              ),
              Text(
                "you like to eat?",
                style: kHomeScreenTitle,
              ),
            ],
          ),
          Icon(
            Icons.notifications_none,
            size: 30.0,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
