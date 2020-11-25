import 'dart:convert';

import 'package:food_app/src/enums/auth_mode.dart';
import 'package:food_app/src/models/user_info_model.dart';
import 'package:food_app/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserScopedModel extends Model {
  List<UserModel> _users = [];
  List<UserInfoModel> _userInfo = [];
  UserModel _authenticatedUser;
  UserInfoModel _authenticatedUserInfo;
  bool _isLoading = false;

  UserModel get authenticatedUser => _authenticatedUser;
  UserInfoModel get authenticatedUserInfo => _authenticatedUserInfo;
  List<UserModel> get users => List.from(_users);
  List<UserInfoModel> get userInfo => List.from(_userInfo);
  bool get isLoading => _isLoading;

  Future<bool> fetchUserInfo() async {
    _isLoading = true;
    notifyListeners();

    try {
      http.Response response =
          await http.get("https://food-app-1b825.firebaseio.com/users.json");
      Map<String, dynamic> fetchUserInfo = json.decode(response.body);
      List<UserInfoModel> fetchedUserInfo = [];
      fetchUserInfo.forEach((String id, dynamic userInfo) {
        UserInfoModel userInfoModel = UserInfoModel(
          id: id,
          username: userInfo["username"],
          email: userInfo["email"],
          userType: userInfo["userType"],
          userId: userInfo["localId"],
        );
        fetchedUserInfo.add(userInfoModel);
      });
      _userInfo = fetchedUserInfo;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      print(e);
      _isLoading = false;
      return Future.value(false);
    }
  }

  Future<bool> addUserInfo(Map<String, dynamic> userInfo) async {
    _isLoading = true;
    notifyListeners();

    try {
      http.Response response = await http.post(
          "https://food-app-1b825.firebaseio.com/users.json",
          body: json.encode(userInfo));
      Map<String, dynamic> responseData = json.decode(response.body);
      UserInfoModel userInfoWithId = UserInfoModel(
        id: responseData["name"],
        email: userInfo["email"],
        username: userInfo["username"],
        userType: userInfo["userType"],
        userId: userInfo["localId"],
        // phoneNumber: userInfo["phoneNumber"],
        // token: userInfo["token"],
        // firstName: userInfo["firstName"],
        // lastName: userInfo["lastName"],
      );

      _userInfo.add(userInfoWithId);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<UserInfoModel> getUserInfo(String userId) async {
    final bool response = await fetchUserInfo();
    UserInfoModel foundUserInfo;

    if (response) {
      for (int i = 0; i < _userInfo.length; i++) {
        if (userInfo[i].userId == userId) {
          foundUserInfo = userInfo[i];
          break;
        }
      }
    }
    return Future.value(foundUserInfo);
  }

  UserInfoModel getUserDetail(String userId) {
    fetchUserInfo();
    UserInfoModel foundUserInfo;

    for (int i = 0; i < _userInfo.length; i++) {
      if (userInfo[i].userId == userId) {
        foundUserInfo = userInfo[i];
        break;
      }
    }

    return foundUserInfo;
  }

  Future<Map<String, dynamic>> authenticated(
    String email,
    String password, {
    AuthMode authMode = AuthMode.SignIn,
    Map<String, dynamic> userInfo,
  }) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
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
        );

        if (authMode == AuthMode.SignUp) {
          userInfo["localId"] = responseBody["localId"];
          addUserInfo(userInfo);
          errorMsg = "Sign up successfully!";
        } else {
          _authenticatedUserInfo = await getUserInfo(responseBody["localId"]);
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

  void logout() {
    _authenticatedUser = null;
    _authenticatedUserInfo = null;
  }
}
