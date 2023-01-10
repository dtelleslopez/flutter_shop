import 'package:flutter/material.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;

    print(products);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(products[i].title, products[i].imageUrl),
              const Divider(),
            ],
          ),
          itemCount: products.length,
        ),
        // child: Container(),
      ),
    );
  }
}
