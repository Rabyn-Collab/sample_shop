import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/cart.dart';
import 'package:http/http.dart' as http;
class OrderItem{
final String id;
final int  amount;
final List<Cart> products;
final DateTime dateTime;


OrderItem({this.dateTime,  this.id,  this.products,this.amount});

factory OrderItem.fromJson(Map<String, dynamic> json){
 return OrderItem(
 id: json['id'],
  dateTime: DateTime.parse(json['date']),
  amount: json['amount'],
  products: (json['products'] as List).map((e) => Cart.fromJson(e)).toList()
 );
}



}


final orderProvider = ChangeNotifierProvider((ref) => Orders());
final streamOrder = FutureProvider((ref) => Orders().getData());
class Orders extends ChangeNotifier{
List<OrderItem> orders = [];

final url = 'https://61951fdc74c1bd00176c6b9b.mockapi.io/orders';

Stream<List<OrderItem>> productStream() async*{
 while(true){
  await Future.delayed(Duration(milliseconds: 500));
  final products = await getData();
  yield products;
 }

}


//future provider
 Future<List<OrderItem>> getData() async {
  try {
   final response = await http.get(Uri.parse(url));
   final extractData = jsonDecode(response.body);
   List<OrderItem> datas = (extractData as List)
       .map((e) => OrderItem.fromJson(e))
       .toList();
   return datas;
  } catch (err) {
   print(err);
  }
 }


Future<void> addOrderToDatabase(List<Cart> cartProducts, int total) async {
 try {
  await http.post(Uri.parse(url),
   headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
   },
   body: jsonEncode({
    'amount': total,
    'date': DateTime.now().toString(),
    'products': cartProducts.map((e) => e.toJson()).toList(),
   }),
  );
 } catch (err) {
  print(err);
 }
}


void addOrder(List<Cart> cartProducts, int total) {
 orders.insert(0, OrderItem(
   id: DateTime.now().toString(),
    amount: total,
   dateTime: DateTime.now(),
   products: cartProducts
 ));
 notifyListeners();
}

}