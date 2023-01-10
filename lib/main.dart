import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import 'package:provider/provider.dart';
import '../screens/cart_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../providers/orders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Products()),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProvider(create: (_) => Orders())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Shop',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.purple,
              secondary: Colors.deepOrange,
            ),
          ),
          home: const ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
            CartScreen.routeName: (_) => const CartScreen(),
            OrdersScreen.routeName: (_) => const OrdersScreen(),
            UserProductsScreen.routeName: (_) => const UserProductsScreen(),
          },
        ));
  }
}
