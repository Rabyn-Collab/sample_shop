import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shopon/provider/order.dart';



class OrderScreen extends ConsumerWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final orderData = watch(orderProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
        body: ListView.builder(
          itemCount: orderData.orders.length,
            itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
           childrenPadding: EdgeInsets.all(10),
                  title: Text('Total Amount \$${orderData.orders[index].amount}'),
                subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(orderData.orders[index].dateTime)),
                children: orderData.orders[index].products.map((prod){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(prod.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Text('${prod.quantity} x ${prod.price}', style: TextStyle(fontSize: 18,
                          color: Colors.black54,
                          ),)
                    ],
                  );
                } ).toList(),
              ),
            );
            }
        )
    );
  }
}
