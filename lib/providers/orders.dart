import 'package:flutter/widgets.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://flutter-shop-7763b-default-rtdb.firebaseio.com/orders.json';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data == null) {
        return;
      }

      final List<OrderItem> orders = [];

      (data as Map<String, dynamic>).forEach((id, order) {
        orders.add(OrderItem(
          id: id,
          amount: order['amount'],
          dateTime: DateTime.parse(order['dateTime']),
          products: (order['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
        ));
      });

      _orders = orders;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      const url =
          'https://flutter-shop-7763b-default-rtdb.firebaseio.com/orders.json';

      final timestamp = DateTime.now();
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((element) => {
                      'id': element.id,
                      'title': element.title,
                      'quantity': element.quantity,
                      'price': element.price,
                    })
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              products: cartProducts,
              dateTime: timestamp));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
