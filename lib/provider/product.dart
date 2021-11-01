import 'package:flutter/foundation.dart';



class Product extends ChangeNotifier{

 final String id;
 final String title;
 final String description;
 final double price;
 final String imageUrl;
 bool isFavourite;

 Product({
   this.imageUrl,
   this.description,
   this.title,
   this.id,
   this.isFavourite = false,
   this.price
 });


 void toggle(){
   isFavourite = !isFavourite;
   notifyListeners();
 }


}