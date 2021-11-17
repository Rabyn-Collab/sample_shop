import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/product.dart';
import 'package:http/http.dart' as http;
final productProvider = ChangeNotifierProvider((ref) => Products());

final streamProduct = StreamProvider((ref) => Products().productStream());
final futureProduct = FutureProvider((ref) => Products().getData());



class Products extends ChangeNotifier{



List<Product> _items = [
  // Product(
  //   imageUrl: 'https://media.istockphoto.com/photos/fashion-clothes-on-a-rack-in-a-light-background-indoors-place-for-picture-id1257563298?b=1&k=20&m=1257563298&s=170667a&w=0&h=Hhf0-AsQp7Z7k9q8XKHfQUY86uPJvE8vmmGHXihWS_M=',
  //   title: 'Clothes',
  //   id: '1',
  //   description: 'good one',
  //   isFavourite: false,
  //   price: 700
  // ),
  // Product(
  //     imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHwwfDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //     title: 'Shoes',
  //     id: '2',
  //     description: 'good one 1',
  //     isFavourite: false,
  //     price: 800
  // ),
  // Product(
  //     imageUrl: 'https://media.istockphoto.com/photos/clothes-blue-jeans-picture-id186870715?b=1&k=20&m=186870715&s=170667a&w=0&h=oXtYb930_QqApSUPvYp8HqNobs9t_wIGWK5xQEfTsbM=',
  //     title: 'Jeans',
  //     id: '3',
  //     description: 'good one 2',
  //     isFavourite: false,
  //     price: 700
  // ),
  // Product(
  //     imageUrl: 'https://images.unsplash.com/photo-1495105787522-5334e3ffa0ef?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8amFja2V0fGVufDB8MHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //     title: 'Jacket',
  //     id: '4',
  //     description: 'good one 5',
  //     isFavourite: false,
  //     price: 900
  // ),
];

List<Product> get items{
  return [..._items];
}

//stream provider
  Stream<List<Product>> productStream() async*{
     while(true){
       await Future.delayed(Duration(milliseconds: 500));
       final products = await getData();
       yield products;
     }

  }


//future provider
Future<List<Product>> getData() async{

const url = 'https://61951fdc74c1bd00176c6b9b.mockapi.io/products';

try{
   final response = await http.get(Uri.parse(url));
   final extractData = jsonDecode(response.body);
   List<Product>  datas = (extractData as List).map((e) => Product.fromJson(e)).toList();
   return datas;
}catch(err){
  print(err);
}

}

























List<Product> get favouriteItems{
  return  items.where((element) => element.isFavourite == true).toList();
}

void toggle(String id){
  final item = items.firstWhere((element) => element.id == id);
  item.isFavourite = !item.isFavourite;
  notifyListeners();
}
}