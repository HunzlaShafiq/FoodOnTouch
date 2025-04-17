class  ItemModel{

  final String itemImageUrl;
  final String itemName;
  final String itemDescription;
  final String itemPrice;
  final String id;


  ItemModel(
      {
        required this.id,
        required this.itemImageUrl,
        required this.itemName,
        required this.itemDescription,
        required this.itemPrice
      });


}