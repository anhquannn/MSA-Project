import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Category.dart';
import 'package:gmarket/Models/Category.dart';

class Category_Provider extends ChangeNotifier{
  List<Category> listCategory=[];
  bool isLoading=false;
  Category? category;

  List<Category> get list =>listCategory;
  bool get loading =>isLoading;
  Category? get cate=>category;

  Future getAllCategory()async{
    isLoading=true;
    notifyListeners();
    try{
      List<Category> cate=await categoryHttp().getAllCategory();
      listCategory=cate;
        }catch(e){
    } finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future createCategory(Category cate)async{
    final result=await categoryHttp().createCategory(cate);
    if(result==true){
      getAllCategory();
    }else{
      print("Provider - Khong the tao Category");
    }
  }

  Future updateCategory(Category cate)async{
    final result=await categoryHttp().updateCategory(cate);
    if(result==true){
      getAllCategory();
    }else{
      print("Provider - Khong the update category");
    }
  }

  Future deleteCategory(int id) async{
    final result=await categoryHttp().deleteCategory(id);
    if(result==true){
      getAllCategory();
    }else{
      print("Provider - Khong the delete category");
    }
  }

  Future getCategoryById(int id) async{
    category=null;
    isLoading=true;
    notifyListeners();
    try{
      final result=await categoryHttp().getCategoryById(id);
      if(result!=null){
        category=result;
      }else{
        print("Provider - Khong the get category");
      }
    }catch(e){
      Exception('$e');
    }
    finally{
      isLoading=false;
      notifyListeners();
    }
  }
}