import 'package:flutter/material.dart';



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
          ListTile(
            title: Text('Home'),
            leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.shop),
            ),
          ),
          ListTile(
            title: Text('Shop'),
            leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
    );
  }
}
