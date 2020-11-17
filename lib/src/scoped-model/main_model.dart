import 'package:food_app/src/scoped-model/food_scopedmodel.dart';
import 'package:food_app/src/scoped-model/user_scopedmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with FoodScopedModel, UserScopedModel {}
