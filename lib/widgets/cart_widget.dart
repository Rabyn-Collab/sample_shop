import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shopon/provider/cart.dart';
import 'package:shopon/screens/cart_screen.dart';



class CartWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    final cart = watch(cartProvider);
    return InkWell(
      onTap: (){
        Get.to(() => CartScreen());
      },
      child: Container(
        padding:  EdgeInsets.only(top: 7, right: 15),
        child: Stack(
          children: [
           Padding(
             padding: const EdgeInsets.only(top: 4),
             child: CircleAvatar(
               child: IconButton(
                 onPressed: (){
                   Get.to(() => CartScreen());
                 },
                 icon: Icon(Icons.shopping_cart),
               ),
             ),
           ),
           if(cart.itemCount() !=0)  Positioned(
                left: 20,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.pink,
                  child: Text(cart.itemCount().toString(),
                  style: TextStyle(fontSize: 15),),
                ))
          ],
        ),
      ),
    );
  }
}
