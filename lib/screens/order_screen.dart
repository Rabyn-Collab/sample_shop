import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shopon/provider/orders.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
        body: Consumer(
          builder: (context, watch,child) {
            final data = watch(orderProvider);
            return ListView.builder(
                itemCount: data.orders.length,
                itemBuilder: (context, index) => ExpansionTile(
                    title: Text('Total Amount \$${data.orders[index].amount}'),
                  subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(data.orders[index].dateTime)),
                  children: data.orders[index].products.map((prod){
                     return Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          Text(prod.title, style: TextStyle(fontSize: 20),),
                          Text('${prod.quantity} x  ${prod.price}', style: TextStyle(fontSize: 20),)
                         ],
                       ),
                     );
                  }).toList(),
                )
            );
          }
    )
    );
  }
}
