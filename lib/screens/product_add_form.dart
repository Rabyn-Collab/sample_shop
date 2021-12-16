import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/product.dart';
import 'package:shopon/provider/products.dart';

class ProductAddFrom extends StatelessWidget {

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
                label: 'title',
                controller: titleController
              ),
                  SizedBox(height: 5,),
              _buildTextFormField(
                label: 'description',
                controller: descController
              ),
                  SizedBox(height: 5,),
              _buildTextFormField(
                label: 'imageUrl',
                controller: imageController
              ),
                  SizedBox(height: 5,),
              _buildTextFormField(
                label: 'price',
                controller: priceController
              ),
                  SizedBox(height: 5,),
                  ElevatedButton(onPressed: (){
          _form.currentState.save();

          final newProduct  = Product(
            title: titleController.text,
            imageUrl: imageController.text,
            price: int.tryParse(priceController.text) ,
            description: descController.text,
            isFavourite: false
          );
          context.read(productProvider).addProduct(newProduct);
                    
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
