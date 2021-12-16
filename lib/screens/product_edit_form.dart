import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/product.dart';
import 'package:shopon/provider/products.dart';

class ProductEditFrom extends StatelessWidget {

  final Product product;
  ProductEditFrom(this.product);


  final _form = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _form,
          child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextFormField(
                          label: 'Title',
                          controller: titleController..text = product.title,
                      ),
                      SizedBox(height: 5,),
                      _buildTextFormField(
                          label: 'Description',
                          controller: descController..text = product.description
                      ),
                      SizedBox(height: 5,),
                      _buildTextFormField(
                          label: 'ImageUrl',
                          controller: imageController..text = product.imageUrl
                      ),
                      SizedBox(height: 5,),
                      _buildTextFormField(
                          label: 'Price',
                          controller: priceController..text = product.price.toString()
                      ),
                      SizedBox(height: 5,),
                      ElevatedButton(
                          onPressed: (){
                        _form.currentState.save();
                        final newProduct  = Product(
                            title: titleController.text,
                            price: int.tryParse(priceController.text) ,
                            imageUrl: imageController.text,
                            description: descController.text,
                          id: product.id,
                          isFavourite: false
                        );
                        context.read(productProvider).updateProduct(newProduct);
                        Navigator.of(context).pop();
                      }, child: Text('Submit'))
                    ],
                  ),
                ),
              )),
        )
    );
  }

  TextFormField _buildTextFormField({String label, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }
}
