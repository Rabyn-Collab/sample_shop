import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final prodProvider = ChangeNotifierProvider((ref) => Product());


class Product extends ChangeNotifier{

 final String id;
 final String title;
 final String description;
 final int price;
 final String imageUrl;
 bool isFavourite;


 int currentIndex = 2;

 Product({
   this.imageUrl,
   this.description,
   this.title,
   this.id,
   this.isFavourite = false,
   this.price
 });

factory Product.fromJson(Map<String, dynamic> json){
  return Product(
    id: json['id'],
    title: json['title'],
    price: json['price'],
    isFavourite: json['isFavourite'],
    imageUrl: json['imageUrl'],
    description: json['description']
  );
}

 void toggleTheme(int index){
   currentIndex = index;
   notifyListeners();
 }

}