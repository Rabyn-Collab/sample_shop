import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shopon/provider/orders.dart';

class OrderScreen extends ConsumerWidget {


  @override
  Widget build(BuildContext context, watch) {
    final order = watch(streamOrder);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
        body: order.when(
            data: (data){
              return Consumer(
                  builder: (context, watch,child) {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => ExpansionTile(
                          title: Text('Total Amount \$${data[index].amount}'),
                          subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(data[index].dateTime)),
                          children: data[index].products.map((prod){
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
              );
            },
            loading: () => Center(child: CircularProgressIndicator(),),
            error: (err, stack) => Text('$err')
        )
    );
  }
}
