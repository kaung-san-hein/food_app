import 'package:flutter/material.dart';
import 'package:food_app/src/enums/auth_mode.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/screens/sign_in_screen.dart';
import 'package:food_app/src/widgets/button.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _toggleVisibility = true;
  // bool _toggleConfirmVisibility = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _username;
  String _password;

  void onSubmit(Function authenticated) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Map<String, dynamic> userInfo = {
        "email": _email,
        "username": _username,
        "userType": "customer",
      };

      authenticated(
        _email,
        _password,
        authMode: AuthMode.SignUp,
        userInfo: userInfo,
      ).then((response) {
        Navigator.of(context).pop();
        if (!response["hasError"]) {
          Navigator.of(context).pushReplacementNamed("/mainScreen");
        } else {
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text("${response["message"]}"),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      });
    }
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xffbdc2cb),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String value) {
        _email = value.trim();
      },
      validator: (String value) {
        String errorMsg;
        if (!value.contains('@')) {
          errorMsg = 'Email field is incorrect.';
        }
        if (value.isEmpty) {
          errorMsg = 'Email field is required.';
        }
        return errorMsg;
      },
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(
          color: Color(0xffbdc2cb),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String value) {
        _username = value.trim();
      },
      validator: (String value) {
        String errorMsg;
        if (value.isEmpty) {
          errorMsg = 'Username field is required.';
        }
        return errorMsg;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Color(0xffbdc2cb),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onSaved: (String value) {
        _password = value.trim();
      },
      validator: (String value) {
        String errorMsg;
        if (value.isEmpty) {
          errorMsg = 'Password field is required.';
        }
        return errorMsg;
      },
    );
  }

  // Widget _buildConfirmPasswordTextField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       hintText: "Confirm Password",
  //       hintStyle: TextStyle(
  //         color: Color(0xffbdc2cb),
  //         fontSize: 18.0,
  //       ),
  //       suffixIcon: IconButton(
  //         onPressed: () {
  //           setState(() {
  //             _toggleConfirmVisibility = !_toggleConfirmVisibility;
  //           });
  //         },
  //         icon: _toggleConfirmVisibility
  //             ? Icon(Icons.visibility_off)
  //             : Icon(Icons.visibility),
  //       ),
  //     ),
  //     obscureText: _toggleConfirmVisibility,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildUsernameTextField(),
                        SizedBox(height: 20.0),
                        _buildEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                        // SizedBox(height: 20.0),
                        // _buildConfirmPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ScopedModelDescendant<MainModel>(
                  builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return Button(
                      btnText: "Sign Up",
                      onTap: () {
                        showLoadingIndicator(context, "Sign up ...");
                        onSubmit(model.authenticated);
                      },
                    );
                  },
                ),
                Divider(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I already have a account?",
                      style: TextStyle(
                        color: Color(0xffbdc2cb),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
