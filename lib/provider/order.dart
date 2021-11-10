import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/cart.dart';

class OrderItem{
  final String id;
  final int amount;
  final List<Cart> products;
  final DateTime dateTime;

  OrderItem({this.dateTime, this.id, this.products, this.amount});


}

final orderProvider = ChangeNotifierProvider((ref) => Orders());
class Orders extends ChangeNotifier{

 List<OrderItem> orders = [];

 void addOrder(List<Cart> products, int total){
   orders.insert(0, OrderItem(
     id: DateTime.now().toString(),
     amount: total,
     dateTime: DateTime.now(),
     products: products
   ));

   notifyListeners();
 }


}