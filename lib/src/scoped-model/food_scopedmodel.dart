import 'dart:convert';
import 'package:food_app/src/models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class FoodScopedModel extends Model {
  List<FoodModel> _foods = [];
  bool _isLoading = false;

  List<FoodModel> get foods => List.from(_foods);
  bool get isLoading => _isLoading;
  int get foodSize => _foods.length;

  Future<bool> addFood(FoodModel food) async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> foodData = {
        "title": food.name,
        "description": food.description,
        "category": food.category,
        "price": food.price,
        "discount": food.discount,
      };
      http.Response response = await http.post(
          "https://food-app-1b825.firebaseio.com/foods.json",
          body: json.encode(foodData));
      Map<String, dynamic> responseData = json.decode(response.body);

      FoodModel foodWithId = FoodModel(
        id: responseData["name"],
        name: food.name,
        description: food.description,
        category: food.category,
        price: food.price,
        discount: food.discount,
      );
      _foods.add(foodWithId);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<void> fetchFood() async {
    try {
      http.Response response =
          await http.get("https://food-app-1b825.firebaseio.com/foods.json");
      Map<String, dynamic> fetchFood = json.decode(response.body);
      List<FoodModel> fetchedFoodItems = [];
      fetchFood.forEach((String id, dynamic food) {
        FoodModel foodModel = FoodModel(
          id: id,
          name: food["title"],
          price: food['price'],
          discount: food['discount'],
          category: food["category"],
          description: food["description"],
        );
        fetchedFoodItems.add(foodModel);
      });
      _foods = fetchedFoodItems;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updateFood(Map<String, dynamic> foodData, String foodId) async {
    _isLoading = true;
    notifyListeners();

    FoodModel idFood = getFoodById(foodId);

    int foodIndex = _foods.indexOf(idFood);

    try {
      await http.put(
          "https://food-app-1b825.firebaseio.com/foods/${foodId}.json",
          body: json.encode(foodData));
      FoodModel updateFoodData = FoodModel(
        id: foodId,
        name: foodData["title"],
        description: foodData["description"],
        category: foodData["category"],
        price: foodData["price"],
        discount: foodData["discount"],
      );
      _foods[foodIndex] = updateFoodData;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  FoodModel getFoodById(String id) {
    FoodModel foodModel;
    for (int i = 0; i < _foods.length; i++) {
      if (_foods[i].id == id) {
        foodModel = _foods[i];
        break;
      }
    }
    return foodModel;
  }

  Future<bool> deleteFood(String foodId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await http
          .delete("https://food-app-1b825.firebaseio.com/foods/${foodId}.json");
      _foods.removeWhere((FoodModel foodModel) => foodModel.id == foodId);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }
}
