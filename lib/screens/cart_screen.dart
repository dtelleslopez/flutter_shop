import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders.dart';
import 'package:flutter_shop/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cartProvider.items.values.toList(),
                            cartProvider.totalAmount);
                        cartProvider.clear();
                      },
                      child: const Text('Order Now'))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => CartItem(
                  cartProvider.items.values.toList()[i].id,
                  cartProvider.items.keys.toList()[i],
                  cartProvider.items.values.toList()[i].title,
                  cartProvider.items.values.toList()[i].price,
                  cartProvider.items.values.toList()[i].quantity),
              itemCount: cartProvider.items.length,
            ),
          )
        ],
      ),
    );
  }
}
