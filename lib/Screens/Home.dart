import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/CategoriesProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/FetchProductsProvider.dart';
import 'package:fooddelivery/Screens/ProductPreview.dart';
import 'package:fooddelivery/Utils/Components/CategoriesList.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:fooddelivery/Utils/Components/ProductsShow.dart';
import 'package:fooddelivery/Utils/LoadingSkletons/CategoryLoadingSkeleton.dart';
import 'package:fooddelivery/Utils/LoadingSkletons/ProductsLoadingSkeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool selectedCategory = false;
  String selectItemsSpecificCategory = '';

  ValueNotifier<String> selectedItemColor = ValueNotifier('All');

  final categoryRefFetchItem =
      FirebaseFirestore.instance.collection('Categories');

  void all() {
    setState(() {
      selectedCategory = false;
    });
  }

  final searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<FetchProductsProvider>(context, listen: true);
    final isAllCategories =
        Provider.of<CategoriesProvider>(context, listen: true).isAllCategories;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Row(
                  children: [
                    Text(
                      'Delicious',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Food',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(fontSize: 25)),
                    )
                  ],
                )),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: TextFormField(
                  controller: searchController,
                  onChanged: (val){
                    if(val.isEmpty){
                      productsProvider.checkSearching(false);
                    }
                    else{
                      productsProvider.checkSearching(true);
                      productsProvider.filterItemsSearch(val,isAllCategories);
                    }

                  },
                  decoration: InputDecoration(
                      hintText: 'Burger',
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      prefixIcon: Icon(Icons.search),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.amberAccent)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey)
                      )
                  )
              ),
            ),

            SizedBox(
              height: 120,
              child: Consumer<CategoriesProvider>(
                  builder: (context, providerValue, child) {
                if (providerValue.isLoading) {
                  return CategoryLoadingSkeleton();
                } else {
                  return Row(
                    children: [
                      CategoriesList(
                          categoryName: "All",
                          categoryUrl: allFoodUrl,
                          selectedCategory: providerValue.selectedCategoryIs,
                          onTab: () {
                            providerValue.changeCategory("All");
                            providerValue.allCategories(false);
                          }),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: providerValue.categories.length,
                            itemBuilder: (context, index) {
                              final category = providerValue.categories[index];
      
                              final String categoryName = category.categoryName;
                              final String categoryUrl =
                                  category.categoryImageUrl;
                              final String categoryId = category.id;
      
                              return CategoriesList(
                                categoryName: categoryName,
                                categoryUrl: categoryUrl,
                                selectedCategory:
                                    providerValue.selectedCategoryIs,
                                onTab: () {
                                  providerValue.changeCategory(categoryName);
                                  providerValue.allCategories(true);
                                  setState(() {
                                    selectItemsSpecificCategory =
                                        categoryId.toString();
                                    productsProvider.selectedCategoriesFetch(
                                        selectItemsSpecificCategory);
                                  });
                                },
                              );
                            }),
                      )
                    ],
                  );
                }
              }),
            ),
            Expanded(child: Consumer<FetchProductsProvider>(
                builder: (context, itemProviderValue, child) {
              if (itemProviderValue.isLoading) {
                return ProductsLoadingSkleton();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                      itemCount:
                          itemProviderValue.isSearching?
                          itemProviderValue.searchItems.length
                           :
                          isAllCategories
                          ? itemProviderValue.specificItems.length
                          : itemProviderValue.allItems.length

                      ,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              childAspectRatio: .9,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final item =
                        itemProviderValue.isSearching?
                        itemProviderValue.searchItems[index]
                            :
                         isAllCategories
                            ? itemProviderValue.specificItems[index]
                            : itemProviderValue.allItems[index];
      
                        final String itemImageUrl = item.itemImageUrl;
                        final String itemName = item.itemName;
                        final String itemDescription = item.itemDescription;
                        final String itemPrice = item.itemPrice;
                        final String id = item.id;


                          return OpenContainer(
                              transitionDuration: const Duration(milliseconds: 600),
                              transitionType: ContainerTransitionType.fadeThrough,
                              closedShape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              closedBuilder: (context, VoidCallback openContainer) {
                                return ProductsShow(
                                    itemImageUrl: itemImageUrl,
                                    itemName: itemName,
                                    itemDescription: itemDescription,
                                    itemPrice: itemPrice,
                                    onTabItem: openContainer);
                              },
                              openBuilder: (context, _) {
                                return ProductPreview(data: {
                                  'itemId': id,
                                  'itemName': itemName,
                                  'itemDescription': itemDescription,
                                  'itemPrice': itemPrice,
                                  'itemImageUrl': itemImageUrl
                                });
                              });


                      }),
                );
              }
            })
           ),
          ],
        ),
      ),
    );
  }
}
