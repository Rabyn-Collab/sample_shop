import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shopon/provider/cart.dart';
import 'package:shopon/provider/products.dart';
import 'package:shopon/screens/cart_screen.dart';
import 'package:shopon/widgets/cart_widget.dart';
import 'package:shopon/widgets/drawer_widget.dart';



class ProductHome extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    final prod = watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
     actions: [
       PopupMenuButton(
           color: Colors.yellow,
           itemBuilder: (context) => [
             PopupMenuItem(
               value: 1,
                 child: Text('Favorite')),
             PopupMenuItem(
                 value: 2,
                 child: Text('All')),
           ]
       ),
       CartWidget()
     ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
            itemCount:  prod.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisExtent: 190),
            itemBuilder: (context, index) {
              return  ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  child: Image.network(prod.items[index].imageUrl),
                  footer: GridTileBar(
                    leading: IconButton(
                      onPressed: () {
                        context.read(productProvider).toggle(prod.items[index].id);
                      },
                      icon: Icon(prod.items[index].isFavourite ? Icons.favorite : Icons.favorite_border),
                    ),
                    trailing: IconButton(
                      onPressed: () {
context.read(cartProvider).addItem(prod.items[index].id, prod.items[index].price, prod.items[index].title);
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),
                    title: Text(
                      prod.items[index].title,
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.black45,
                  ),
                ),
              );
            }),
      ),
      drawer: DrawerWidget(),
    );
  }
}
