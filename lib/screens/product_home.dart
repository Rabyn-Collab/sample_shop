import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/cart.dart';
import 'package:shopon/provider/products.dart';
import 'package:shopon/widgets/cart_widget.dart';
import 'package:shopon/widgets/drawer_widget.dart';



class ProductHome extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    final prod = watch(productProvider);
    final productData = watch(streamProduct);
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
      body: productData.when(
          data: (product){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                  itemCount:  product.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 190),
                  itemBuilder: (context, index) {
                    final prods = product[index];
                    return  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridTile(
                        child: Image.network(product[index].imageUrl),
                        footer: GridTileBar(
                          leading: IconButton(
                            onPressed: () {

                            },
                            icon: Icon(Icons.favorite_border),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              context.read(cartProvider).addItem(prods.id, prods.price, prods.title);
                            },
                            icon: Icon(Icons.shopping_cart),
                          ),
                          title: Text(
                            product[index].title,
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.black45,
                        ),
                      ),
                    );
                  }),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('$err'))),
      drawer: DrawerWidget(),
    );
  }
}
