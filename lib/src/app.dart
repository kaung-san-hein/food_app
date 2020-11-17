import 'package:flutter/material.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/screens/main_screen.dart';
import 'package:food_app/src/screens/sign_in_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        title: "Food Delivery App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        routes: {
          '/': (BuildContext context) => SignInScreen(),
          '/mainScreen': (BuildContext context) =>
              MainScreen(mainModel: mainModel),
        },
        // home: AddFoodScreen(),
      ),
    );
  }
}
