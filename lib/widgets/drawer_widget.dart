import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopon/screens/order_screen.dart';
import 'package:shopon/screens/product_home.dart';



class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          AppBar(
            title: Text('Shopping'),
            centerTitle: true,
          ),
          SizedBox(height: 40,),
          ListTile(
            onTap: (){
              Get.offAll(() => ProductHome());
            },
            title: Text('Home'),
            leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.shop),
            ),
          ),
          ListTile(
            onTap: (){
Get.to(() => OrderScreen());
            },
            title: Text('Orders'),
            leading: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
    );
  }
}
