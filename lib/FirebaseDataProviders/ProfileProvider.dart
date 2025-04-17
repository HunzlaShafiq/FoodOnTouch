
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';

class  ProfileProvider with ChangeNotifier{

  ProfileProvider(){
    fetchProfileData();
    fetchAddresses();
  }


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _selectedAddress ='';
  String get selectAddress => _selectedAddress;

  List _addressesList = [];
  List get addressesList => _addressesList;

  late DocumentSnapshot _profileData;
  DocumentSnapshot get profileData => _profileData;


  clearProfileDataOnUserLogOut(){
    _addressesList.clear();
    notifyListeners();
  }

  refreshProfileDataOnUserLogIn(){
    fetchProfileData();
    fetchAddresses();
  }




  Future<void> fetchProfileData()async{
    _isLoading =true;
    notifyListeners();
    _profileData = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    _isLoading =false;
    notifyListeners();
  }

  Future<void> fetchAddresses()async{
    _isLoading =true;
    notifyListeners();
    List allAddress =[];

    final addressRef =await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Addresses').get();
    for(var getAddress in addressRef.docs){
      allAddress.add({
        'id': getAddress['id'],
        'address': getAddress['address']
      });

    }
    _addressesList = allAddress;
    _isLoading =false;
    notifyListeners();
  }

  Future<void> addNewAddress(String address,BuildContext context)async {
    _isLoading =true;
    notifyListeners();

    final addressRef =FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Addresses');
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    addressRef.doc(id).set({
      'id':id,
      'address':address
    })
        .then((val){
      _isLoading =false;
      notifyListeners();
      fetchAddresses();
      SuccessMessageToast().successToastMessage("Saved");
      Navigator.pop(context);


    })
        .onError((error,stackTrace){
      _isLoading =false;
      notifyListeners();

      ErrorToast().errorToastMessage("Something went wrong!");

    });


  }


  void thisIsSelectedAddress(String address){
    _selectedAddress= address;
    notifyListeners();
  }

}