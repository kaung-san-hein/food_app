import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/button.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodScreen extends StatefulWidget {
  final FoodModel foodModel;

  AddFoodScreen({this.foodModel});

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  String title;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            widget.foodModel != null ? "Update Food Item" : "Add Food Item",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _foodItemFormKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      width: MediaQuery.of(context).size.width,
                      height: 170.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/noimage.png"),
                        ),
                      ),
                    ),
                    _buildTextFormField("Food Title"),
                    _buildTextFormField("Category"),
                    _buildTextFormField("Description", maxLine: 5),
                    _buildTextFormField("Price"),
                    _buildTextFormField("Discount"),
                    SizedBox(height: 100.0),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return Button(
                          btnText: widget.foodModel != null
                              ? "Update Food Item"
                              : "Add Food Item",
                          onTap: () {
                            onSubmit(model.addFood, model.updateFood);
                            if (model.isLoading) {
                              showLoadingIndicator(
                                  context,
                                  widget.foodModel != null
                                      ? "Updating Food Item..."
                                      : "Adding Food Item...");
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      if (widget.foodModel != null) {
        Map<String, dynamic> updateFoodData = {
          "title": title,
          "description": description,
          "category": category,
          "price": double.parse(price),
          "discount": double.parse(discount),
        };

        bool value = await updateFood(updateFoodData, widget.foodModel.id);

        if (value) {
          Navigator.pop(context);
          Navigator.pop(context, value);
        } else {
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text("Updating Food Item was failed!"),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      } else {
        FoodModel newFood = FoodModel(
          name: title,
          category: category,
          description: description,
          price: double.parse(price),
          discount: discount != "" ? double.parse(discount) : 0.0,
        );

        bool value = await addFood(newFood);
        if (value) {
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).primaryColor,
            content: Text("Food Item was successfully added!"),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        } else {
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text("Adding Food Item was failed!"),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.foodModel != null && hint == "Food Title"
          ? widget.foodModel.name
          : widget.foodModel != null && hint == "Category"
              ? widget.foodModel.category
              : widget.foodModel != null && hint == "Description"
                  ? widget.foodModel.description
                  : widget.foodModel != null && hint == "Price"
                      ? widget.foodModel.price.toString()
                      : widget.foodModel != null && hint == "Discount"
                          ? widget.foodModel.discount.toString()
                          : "",
      decoration: InputDecoration(
        hintText: "$hint",
      ),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == "Food Title") {
          return "Food Title is required!";
        } else if (value.isEmpty && hint == "Category") {
          return "Category is required!";
        } else if (value.isEmpty && hint == "Description") {
          return "Description is required!";
        } else if (value.isEmpty && hint == "Price") {
          return "Price is required!";
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        if (hint == "Food Title") {
          title = value;
        } else if (hint == "Category") {
          category = value;
        } else if (hint == "Description") {
          description = value;
        } else if (hint == "Price") {
          price = value;
        } else {
          discount = value;
        }
      },
    );
  }
}
