

class CartItemModel{

  final String itemImageUrl;
  final String itemName;
  final String itemGreetingLine;
  final String itemPrice;
  final String id;
  int itemQuantity;
  final String itemId;
  String itemSize;


  CartItemModel(
      {
        required this.id,
        required this.itemId,
        required this.itemImageUrl,
        required this.itemName,
        required this.itemGreetingLine,
        required this.itemPrice,
        required this.itemQuantity,
        required this.itemSize,
      });




}