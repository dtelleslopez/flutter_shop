import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    Product product =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
          ],
        ),
      ),
    );
  }
}
