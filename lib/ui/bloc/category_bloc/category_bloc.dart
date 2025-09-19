import 'package:ecomm_395/data/remote/model/category_model.dart';
import 'package:ecomm_395/data/remote/repository/categories_repo.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_event.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState>{
  CategoriesRepo categoriesRepo;


  CategoriesBloc({required this.categoriesRepo}): super(CategoriesInitialState()){
    on<GetCategoriesEvent>((event, emit) async {

      emit(CategoriesLoadingState());


      try{

        dynamic res = await categoriesRepo.getCategories();

        if(res["status"]){
          List<CategoryModel> mCategories = CategoryDataModel.fromJson(res).categoryModel ?? [];
          emit(CategoriesLoadedState(allCategories: mCategories));
        }else{
          emit(CategoriesErrorState(errorMsg: res["message"]));
        }

      }catch(e){
        emit(CategoriesErrorState(errorMsg: e.toString()));
      }



    });



  }


}