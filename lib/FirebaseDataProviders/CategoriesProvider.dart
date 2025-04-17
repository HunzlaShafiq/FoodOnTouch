import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddelivery/Models/CategoryModel.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';

class CategoriesProvider with ChangeNotifier{


  CategoriesProvider(){
    fetchCategoriesProvider();
  }

  String _selectedCategoryIs = "All";
  String get selectedCategoryIs =>_selectedCategoryIs;

  void changeCategory(String val){
    _selectedCategoryIs =val;
    notifyListeners();
  }

  bool _isAllCategories = false;
  bool get isAllCategories =>_isAllCategories;

  void allCategories(bool val){
    _isAllCategories =val;
    notifyListeners();
  }


  List<CategoryModel> _categories =[];
  bool _isLoading =false;


  List<CategoryModel> get categories =>_categories;
  bool get isLoading =>_isLoading;



  fetchCategoriesProvider(){

    fetchCategories();

  }

  clearCategoriesOnUserLogOut(){
    _categories =[];
    notifyListeners();
  }

  refreshCategoriesOnUserLogIn(){
    fetchCategories();
  }

  Future<void> fetchCategories() async{

    _isLoading =true;
    notifyListeners();

    QuerySnapshot snapshot =  await FirebaseFirestore.instance.collection('Categories').get();
try
    {
      _categories = snapshot.docs.map((doc) {
        return CategoryModel(
            id: doc.id,
            categoryName: doc['categoryName'],
            categoryImageUrl: doc['categoryUrl']);
      }).toList();
    }
catch(e)
    {
      ErrorToast().errorToastMessage(e.toString());
    }
finally
    {
      _isLoading = false;
      notifyListeners();
    }
  }






}