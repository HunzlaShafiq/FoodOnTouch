import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/CartProvider.dart';
import 'package:fooddelivery/Provider/BottomNavProvider.dart';
import 'package:fooddelivery/Provider/FavouriteProvider.dart';
import 'package:fooddelivery/Provider/InternetConnectionCheckerProvider.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/AddCartContainer.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/FavoriteContainer.dart';
import 'package:fooddelivery/Utils/Components/IncAndDecContainer.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';
import 'package:fooddelivery/Utils/Components/SelectProductSize.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductPreview extends StatefulWidget {
  final dynamic data;
  const ProductPreview({super.key, required this.data});

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  Color unSelectedBoxColor = Colors.grey.shade100;
  Color selectedBoxColor = Colors.amberAccent.shade200;

  //this is use provider concept to change value in stateful widget with out rebuild whole widget
  ValueNotifier<String> sizeSelection = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {


    final checkInternet = Provider.of<InternetConnectionCheckerProvider>(context,listen: false);

    String getAllWordsExceptLast(String input) {
      List<String> words = input.split(' ');
      if (words.length > 1) {
        words.removeLast();
        return words.join(' ');
      }
      return ''; // Return empty string if there's only one word or the input is empty
    }

    String getLastWord(String input) {
      List<String> words = input.split(' ');
      if (words.isNotEmpty) {
        return words.last;
      }
      return ''; // Return empty string if the input is empty
    }

    var itemNameFirst = getAllWordsExceptLast(widget.data['itemName']);
    var itemNameLast = getLastWord(widget.data['itemName']);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 24,
            )),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                  size: 26,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          itemNameFirst,
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          itemNameLast,
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(fontSize: 25)),
                        )
                      ],
                    ),
                    Text(
                      widget.data['itemDescription'],
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Consumer<CartProvider>(
                        builder: (context, itemCartProviderValues, child) {
                      String idOfItemInCart = '';
                      int quantityOfCartItem = 0;

                      if (itemCartProviderValues.itemIdList
                          .contains(widget.data['itemId'])) {
                        itemCartProviderValues.itemSelectedToCart(true);
                      } else {
                        itemCartProviderValues.itemSelectedToCart(false);
                      }

                      for (var checkQuantity
                          in itemCartProviderValues.cartItemsList) {
                        if (widget.data['itemId'] == checkQuantity.itemId) {
                          idOfItemInCart = checkQuantity.id;
                          quantityOfCartItem = checkQuantity.itemQuantity;
                          sizeSelection.value = checkQuantity.itemSize;
                        }
                      }

                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              MyNetworkCacheImage(imageUrl: widget.data['itemImageUrl'], height: 350, width: 350),
                              Positioned(
                                right: 40,
                                bottom: 50,
                                child: itemCartProviderValues.itemAddedCart
                                    ? Container(
                                        height: 70,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 7,
                                                  offset: Offset(4, 4)),
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Center(
                                            child: Text(
                                          quantityOfCartItem.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : InkWell(
                                        borderRadius: BorderRadius.circular(40),
                                        onTap: () async {
                                          // final SharedPreferences itemId = await SharedPreferences.getInstance();
                                          final id = DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString();
                                          // itemId.setString("itemID", id);

                                          final itemQuantity =
                                              itemCartProviderValues
                                                  .itemQuantityValue;
                                          if(await checkInternet.checkInternetConnection(context)) {
                                            addItemToCart(id, itemQuantity,
                                                sizeSelection.value);
                                          }
                                        },
                                        child: Container(
                                          height: 70,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 7,
                                                    offset: Offset(4, 4)),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: const Center(
                                              child: Text(
                                            "ADD",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                              ),
                              itemCartProviderValues.itemAddedCart
                                  ? Positioned(
                                      right: 85,
                                      bottom: 20,
                                      child: IncAndDecContainer(
                                          onTab: () {
                                            itemCartProviderValues
                                                .updateQuantity(idOfItemInCart,
                                                    quantityOfCartItem + 1);

                                            // itemCartProviderValues.updateQuantity(id);
                                          },
                                          icon: Icons.add),
                                    )
                                  : Container(),
                              itemCartProviderValues.itemAddedCart
                                  ? Positioned(
                                      right: 45,
                                      bottom: 20,
                                      child: IncAndDecContainer(
                                          onTab: () async {
                                            if (quantityOfCartItem > 1) {
                                              itemCartProviderValues
                                                  .updateQuantity(
                                                      idOfItemInCart,
                                                      quantityOfCartItem - 1);
                                            } else if (quantityOfCartItem ==
                                                1) {
                                              itemCartProviderValues
                                                  .deleteItemFromCart(
                                                      idOfItemInCart);
                                            }
                                          },
                                          icon: Icons.remove))
                                  : Container(),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ValueListenableBuilder(
                              valueListenable: sizeSelection,
                              builder: (context, value, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SelectProductSize(
                                        text: 'S',
                                        onTab: () {
                                          sizeSelection.value = 'S';
                                          itemCartProviderValues.updateItemSize(
                                              idOfItemInCart, 'S');
                                        },
                                        boxColor: sizeSelection.value == 'S'
                                            ? selectedBoxColor
                                            : unSelectedBoxColor),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SelectProductSize(
                                        text: 'M',
                                        onTab: () {
                                          sizeSelection.value = 'M';
                                          itemCartProviderValues.updateItemSize(
                                              idOfItemInCart, 'M');
                                        },
                                        boxColor: sizeSelection.value == 'M'
                                            ? selectedBoxColor
                                            : unSelectedBoxColor),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SelectProductSize(
                                        text: 'L',
                                        onTab: () {
                                          sizeSelection.value = 'L';
                                          itemCartProviderValues.updateItemSize(
                                              idOfItemInCart, 'L');
                                        },
                                        boxColor: sizeSelection.value == 'L'
                                            ? selectedBoxColor
                                            : unSelectedBoxColor),
                                  ],
                                );
                              }),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text("Description"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.data['itemDescription'],
                      style: const TextStyle(color: grayLight),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(fontSize: 16, color: grayLight),
                        ),
                        Text(
                          "RS. ${widget.data['itemPrice']}",
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Consumer<FavouriteProvider>(

                            builder: (context, favouriteProviderValues, child) {
                              String id='';

                              for(var checkFavourite in favouriteProviderValues.favouriteItemsList){
                                if(widget.data['itemId']==checkFavourite.itemID){
                                  favouriteProviderValues.isFavourited(true);
                                  id= checkFavourite.id;

                                }
                                else{
                                  favouriteProviderValues.isFavourited(false);

                                }

                              }

                          return FavoriteContainer(
                            onTab: () async{
                              if(await checkInternet.checkInternetConnection(context))
                              {
                                if (!favouriteProviderValues.isFavourite) {
                                  final id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  favouriteProviderValues.addToFavourite(
                                      id,
                                      widget.data['itemName'],
                                      widget.data['itemId'],
                                      widget.data['itemPrice'],
                                      widget.data['itemImageUrl'],
                                      widget.data['itemDescription']);
                                  favouriteProviderValues.isFavourited(true);
                                } else {
                                  favouriteProviderValues
                                      .deleteFavouriteItem(id);
                                }
                              }

                            },
                            isFavorite: favouriteProviderValues.isFavourite,
                          );
                        }),
                        const SizedBox(
                          width: 5,
                        ),
                        AddCartContainer(
                          onTab: () {
                            Provider.of<BottomNavProvider>(context,listen: false).changeIndex(2);
                            Navigator.pushReplacementNamed(context, RoutesName.allScreens);
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addItemToCart(
      String id, int itemQuantity, String itemSize) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final cartReference = FirebaseFirestore.instance
        .collection("CartProducts")
        .doc(currentUserId)
        .collection("UserCartItems");

    try {
      cartReference.doc(id).set({
        'id': id,
        'itemId': widget.data['itemId'],
        'itemName': widget.data['itemName'],
        'itemPrice': widget.data['itemPrice'],
        'itemImageUrl': widget.data['itemImageUrl'],
        'itemGreetingLine': widget.data['itemDescription'],
        'itemQuantity': itemQuantity,
        'itemSize': itemSize,
      }).then((onValue) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        cartProvider.itemSelectedToCart(true);
        cartProvider.getCartItems();

        SuccessMessageToast().successToastMessage("added");
      });
    } catch (e) {
      ErrorToast().errorToastMessage(e.toString());
    }
  }
}
