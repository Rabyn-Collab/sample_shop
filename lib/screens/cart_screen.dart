import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopon/provider/cart.dart';
import 'package:shopon/provider/order.dart';


class CartScreen extends ConsumerWidget {


  @override
  Widget build(BuildContext context, watch) {
    final cart = watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Total', style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Chip(
                      padding: EdgeInsets.all(5),
                      label: Text(cart.totalAmount().toString(), style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.black,
                    ),
                    TextButton(onPressed: (){
                      context.read(orderProvider).addOrder(cart.items.values.toList(), cart.totalAmount());
                      context.read(cartProvider).clear();
                    }, child: Text('Order now'))
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(cart.items.values.toList()[index].id),
                      background: Container(
               color: Colors.pink,
                          child: Icon(Icons.delete, color: Colors.white, size: 40,),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (val){
                        context.read(cartProvider).removeItem(cart.items.keys.toList()[index]);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 34,
                              child: FittedBox(
                                  child: Text('\$${cart.items.values.toList()[index].price}')),
                            ),
                            title: Text(cart.items.values.toList()[index].title),
                            subtitle: Text('${cart.items.values.toList()[index].price} x ${cart.items.values.toList()[index].quantity}'),
                            trailing: Text('${cart.items.values.toList()[index].price * cart.items.values.toList()[index].quantity}'),
                          ),
                        ),
                      ),
                    )
                )
            )
          ],
        )
    );
  }
}
