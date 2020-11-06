import 'package:flutter/material.dart';

class OrderCart extends StatefulWidget {
  @override
  _OrderCartState createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.0,
              width: 45.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Color(0xffd3d3d3)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xffd3d3d3),
                    ),
                  ),
                  Text(
                    "0",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xffd3d3d3),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xffd3d3d3),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 18.0),
            Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/lunch.jpeg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(38.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffd9d9d9),
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ]),
            ),
            SizedBox(width: 18.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Grilled Chicken",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  "\u023b 3.0",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 3.0),
                Container(
                  height: 25.0,
                  width: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Chicken",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "x",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Chicken",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "x",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Chicken",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "x",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.cancel, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
