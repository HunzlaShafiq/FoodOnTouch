
class OrderModel {
  final String orderId;
  final int totalPrice;
  final String deliveryAddress;
  final String paymentType;
  final String orderTime;
  final String orderDate;
  final String status;
  final List<dynamic> items;

  OrderModel(
      {
        required this.orderId,
        required this.totalPrice,
        required this.deliveryAddress,
        required this.paymentType,
        required this.orderTime,
        required this.orderDate,
        required this.status,
        required this.items
      });



}

