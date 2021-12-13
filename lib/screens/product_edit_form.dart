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
                          label: product.title,
                          controller: titleController,
                      ),
                      SizedBox(height: 5,),
                      _buildTextFormField(
                          label: product.description,
                          controller: descController
                      ),
                      SizedBox(height: 5,),
                      _buildTextFormField(
                          label: product.imageUrl.substring(0, 20),
                          controller: imageController
                      ),
                      SizedBox(height: 5,),
                      _buildTextFormField(
                          label: product.price.toString(),
                          controller: priceController
                      ),
                      SizedBox(height: 5,),
                      ElevatedButton(onPressed: (){
                        _form.currentState.save();

                        final newProduct  = Product(
                            title: titleController.text,
                            imageUrl: 'https://media.istockphoto.com/photos/brown-leather-shoe-picture-id187310279?b=1&k=20&m=187310279&s=170667a&w=0&h=5Fc9XC5hfvpffZwfE-BzK6DcajqdN3sQjnPJa-Z0Rnk=',
                            price: int.tryParse(priceController.text) ,
                            description: descController.text,
                          id: product.id,
                          isFavourite: false
                        );
                        context.read(productProvider).updateProduct(newProduct);

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
