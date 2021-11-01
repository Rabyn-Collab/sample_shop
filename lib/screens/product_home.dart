import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/products.dart';
import 'package:shopon/widgets/drawer_widget.dart';


class ProductHome extends ConsumerWidget {


  @override
  Widget build(BuildContext context, watch) {
    final prod = watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
        body: GridView.builder(
          itemCount: prod.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3/2,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisExtent: 190
            ),
            itemBuilder: (context, index) {
              return  Padding(
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridTile(
                      child: Image.network(prod.items[index].imageUrl),
                    footer: GridTileBar(
                      leading: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.favorite_border),
                      ),
                      trailing:  IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.shopping_cart),
                      ),
                      title: Text(prod.items[index].title, textAlign: TextAlign.center,),
                      backgroundColor: Colors.black45,
                    ),
                  ),
                ),
              );
            }
        ),
      drawer: DrawerWidget(),
    );
  }
}
