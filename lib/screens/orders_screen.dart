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
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => OrderItem(ordersProvider.orders[i]),
        itemCount: ordersProvider.orders.length,
      ),
      drawer: const AppDrawer(),
    );
  }
}
