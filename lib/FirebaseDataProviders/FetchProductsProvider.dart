import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddelivery/Models/ItemModel.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';

class FetchProductsProvider with ChangeNotifier {

  FetchProductsProvider(){
    fetchAllItems();
  }




  bool _isSearching = false;
  bool get isSearching => _isSearching;


  void checkSearching(bool val){
    _isSearching =val;
    notifyListeners();
  }

  List<ItemModel> _searchItems = [];
  List<ItemModel> get searchItems => _searchItems;



  List<ItemModel> _allItems = [];
  List<ItemModel> _specificItems = [];
  bool _isLoading = false;

  List<ItemModel> get allItems => _allItems;
  List<ItemModel> get specificItems => _specificItems;
  bool get isLoading => _isLoading;


  clearProductsDataOnUserLogOut(){
    _allItems.clear();
    _specificItems.clear();
    notifyListeners();
  }

  refreshProductsDataOnUserLogIn(){
    fetchAllItems();
  }

  Future<void> fetchAllItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot categorySnapshots = await FirebaseFirestore.instance.collection('Categories').get();

      List<ItemModel> loadedItems = [];

      for (var categoryDoc in categorySnapshots.docs) {
        final QuerySnapshot itemsSnapshot = await categoryDoc.reference.collection('items').get();

        for (var itemDoc in itemsSnapshot.docs) {
          loadedItems.add(ItemModel(
            id: itemDoc['itemId'],
            itemImageUrl: itemDoc['itemImageUrl'],
            itemName: itemDoc['itemName'],
            itemDescription: itemDoc['itemDescription'],
            itemPrice: itemDoc['itemPrice'],
          ));
        }
        loadedItems.shuffle();
      }
      _allItems = loadedItems;
      notifyListeners();

    } catch (e) {
      ErrorToast().errorToastMessage(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> selectedCategoriesFetch(String selectItemsSpecificCategory) async{
    _isLoading = true;
    notifyListeners();
try
    {
      final categoryItemRef = await FirebaseFirestore.instance
          .collection('Categories')
          .doc(selectItemsSpecificCategory)
          .collection('items')
          .get();
      List<ItemModel> items = [];
      for (var categorySnapshot in categoryItemRef.docs) {
        items.add(ItemModel(
            id: categorySnapshot['itemId'],
            itemImageUrl: categorySnapshot['itemImageUrl'],
            itemName: categorySnapshot['itemName'],
            itemDescription: categorySnapshot['itemDescription'],
            itemPrice: categorySnapshot['itemPrice']));
      }

      _specificItems = items;

    }

 catch (e) {
       ErrorToast().errorToastMessage(e.toString());
} finally {
    _isLoading = false;
    notifyListeners();
}
  }




  void filterItemsSearch(String searchValue,bool isSpecific){

     List<ItemModel> dataList=[];

     for(var x in isSpecific ?  specificItems: allItems){
       if(x.itemName.toLowerCase().contains(searchValue.toLowerCase())){
         dataList.add(x);
       }
     }
     _searchItems =dataList;

  }













}
