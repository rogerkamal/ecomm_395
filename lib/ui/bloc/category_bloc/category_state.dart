import 'package:ecomm_395/data/remote/model/category_model.dart';

abstract class CategoriesState{}


class CategoriesInitialState extends CategoriesState{}
class CategoriesLoadingState extends CategoriesState{}
class CategoriesLoadedState extends CategoriesState{
  List<CategoryModel> allCategories ;

  CategoriesLoadedState({required this.allCategories});

}
class CategoriesErrorState extends CategoriesState{
  String errorMsg;


  CategoriesErrorState({required this.errorMsg});

}