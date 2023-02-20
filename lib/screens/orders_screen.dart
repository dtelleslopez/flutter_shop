import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (data.error != null) {
            return const Center(
              child: Text('An error ocurred!'),
            );
          }

          return Consumer<Orders>(
              builder: (ctx, order, child) => ListView.builder(
                    itemBuilder: (_, i) => OrderItem(order.orders[i]),
                    itemCount: order.orders.length,
                  ));
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
