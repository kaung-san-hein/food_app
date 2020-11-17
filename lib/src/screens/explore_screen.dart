import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/src/admin/screens/add_food_screen.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/food_item_card.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 13.0),
        child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return RefreshIndicator(
              onRefresh: model.fetchFood,
              child: ListView.builder(
                itemCount: model.foodSize,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      bool response = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddFoodScreen(foodModel: model.foods[index]),
                        ),
                      );
                      if (response) {
                        SnackBar snackBar = SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text("Food Item was successfully updated!"),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    },
                    onDoubleTap: () {
                      showLoadingIndicator(context, "Deleting Food Item...");
                      model.deleteFood(model.foods[index].id).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: FoodItemCard(foodModel: model.foods[index]),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
