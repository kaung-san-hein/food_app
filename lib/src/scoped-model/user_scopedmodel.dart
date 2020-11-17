import 'dart:convert';

import 'package:food_app/src/enums/auth_mode.dart';
import 'package:food_app/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserScopedModel extends Model {
  List<UserModel> _users = [];
  UserModel _authenticatedUser;
  bool _isLoading = false;

  UserModel get authenticatedUser => _authenticatedUser;
  List<UserModel> get users => List.from(_users);
  bool get isLoading => _isLoading;

  Future<bool> addUserInfo(Map<String, dynamic> userInfo) async {
    _isLoading = true;
    notifyListeners();

    try {
      http.Response response = await http.post(
          "https://food-app-1b825.firebaseio.com/users.json",
          body: json.encode(userInfo));
      Map<String, dynamic> responseData = json.decode(response.body);

      UserModel userWithId = UserModel(
        id: responseData["name"],
        email: userInfo["email"],
        username: userInfo["username"],
        // userType: userInfo["userType"],
        // phoneNumber: userInfo["phoneNumber"],
        // token: userInfo["token"],
        // firstName: userInfo["firstName"],
        // lastName: userInfo["lastName"],
      );

      _users.add(userWithId);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<Map<String, dynamic>> authenticated(
      String email, String password, String username,
      {AuthMode authMode = AuthMode.SignIn}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };

    Map<String, dynamic> userInfo = {
      "email": email,
      "username": username,
    };

    String errorMsg;
    bool isError = false;

    try {
      http.Response response;
      if (authMode == AuthMode.SignUp) {
        response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDxfajKkAZxQMzvqWI83Sc52VcT47KB4Bg",
          body: json.encode(authData),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        addUserInfo(userInfo);
      } else {
        response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDxfajKkAZxQMzvqWI83Sc52VcT47KB4Bg",
          body: json.encode(authData),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody.containsKey('idToken')) {
        _authenticatedUser = UserModel(
          id: responseBody["localId"],
          email: responseBody["email"],
          token: responseBody["idToken"],
          userType: "customer",
        );

        if (authMode == AuthMode.SignUp) {
          errorMsg = "Sign up successfully!";
        } else {
          errorMsg = "Sign in successfully!";
        }
      } else {
        isError = true;
        if (responseBody["error"]["message"] == 'EMAIL_EXISTS') {
          errorMsg = "Email has already existed!";
        } else if (responseBody["error"]["message"] == 'EMAIL_NOT_FOUND') {
          errorMsg = "Email does not exist!";
        } else if (responseBody["error"]["message"] == 'INVALID_PASSWORD') {
          errorMsg = "Password incorrect!";
        }
      }
      _isLoading = false;
      notifyListeners();
      return {
        'message': errorMsg,
        'hasError': isError,
      };
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {
        'message': 'Sign up was failed!',
        'hasError': !isError,
      };
    }
  }
}
