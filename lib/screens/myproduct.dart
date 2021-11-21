import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shopon/provider/products.dart';
import 'package:shopon/screens/product_add_form.dart';




class MyProductScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    final productData = watch(streamProduct);
    return Scaffold(
      appBar: AppBar(
        title: Text('My product'),
        actions: [
          IconButton(
            onPressed: (){
              Get.to(() => ProductAddFrom());
            },
              icon: Icon(Icons.add))
        ],
      ),
        body: productData.when(
            data: (data){
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  thickness: 10,
                ),
                  itemCount: data.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: Container(
                        child: Image.network(data[index].imageUrl),
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: (){

                                }, icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  )
              );
            },
            loading: () => Center(child: CircularProgressIndicator(),),
            error: (err, stack) => Text('err')
        )
    );
  }
}
