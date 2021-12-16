import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Cart{
String id;
String title;
int quantity;
int price;

Cart({this.id, this.quantity, this.price, this.title});


factory Cart.fromJson(Map<String, dynamic> json){
  return Cart(
    title: json['title'],
    quantity: json['quantity'],
    price: json['price'],
    id: json['id']
  );
}

Map<String, dynamic> toJson(){
  return {
    'id': this.id,
    'title' : this.title,
    'quantity': this.quantity,
    'price': this.price
  };
}


}

final cartProvider = ChangeNotifierProvider((ref) => CartProvider());


class CartProvider extends ChangeNotifier{
  Map<String, Cart> items = {};

  int  itemCount(){
    return items.length;
  }

int totalAmount(){
 int total = 0;

items.forEach((key, cartItem) {
  total += cartItem.price * cartItem.quantity;
});

 return total;

}


void addItem(String prodId, int price, String title){
if(items.containsKey(prodId)){
  items.update(prodId, (cartItem) => Cart(
    id: cartItem.id,
    title: cartItem.title,
    price: cartItem.price,
    quantity: cartItem.quantity + 1
  ) );
  notifyListeners();
}else{
  items.putIfAbsent(prodId, () => Cart(
    id: DateTime.now().toString(),
    title: title,
    price: price,
    quantity: 1
  ));
  notifyListeners();
}


}





void removeItem(String prodId){
 items.remove(prodId);
 notifyListeners();
}

void clear(){
    items = {};
    notifyListeners();
}






}