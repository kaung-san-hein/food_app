import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/src/models/user_info_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/custom_list_tile.dart';
import 'package:food_app/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _turnOnNotification = false;
  bool _turnOnLocation = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        UserInfoModel userInfo =
            model.getUserDetail(model.authenticatedUserInfo.userId);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3.0,
                              offset: Offset(0, 4.0),
                              color: Colors.black38,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage("assets/images/breakfast.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${userInfo.username}",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "${userInfo.email}",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          SmallButton(btnText: "Edit"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomListTile(
                            icon: Icons.location_on,
                            text: "Location",
                          ),
                          Divider(height: 10.0, color: Colors.grey),
                          CustomListTile(
                            icon: Icons.visibility,
                            text: "Change Password",
                          ),
                          Divider(height: 10.0, color: Colors.grey),
                          CustomListTile(
                            icon: Icons.shopping_cart,
                            text: "Shipping",
                          ),
                          Divider(height: 10.0, color: Colors.grey),
                          CustomListTile(
                            icon: Icons.payment,
                            text: "Payment",
                          ),
                          Divider(height: 10.0, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "App Notification",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Switch(
                                value: _turnOnNotification,
                                onChanged: (bool value) {
                                  setState(() {
                                    _turnOnNotification = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Divider(height: 10.0, color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Location Tracking",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Switch(
                                value: _turnOnLocation,
                                onChanged: (bool value) {
                                  setState(() {
                                    _turnOnLocation = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Divider(height: 10.0, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Others",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Divider(height: 30.0, color: Colors.grey),
                            Text(
                              "Currency",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Divider(height: 30.0, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
