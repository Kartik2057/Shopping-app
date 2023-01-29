import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem{
  final String id;
  final double  amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
   @required this.id,
   @required this.amount,
   @required this.products,
   @required this.dateTime,
  });
}


class Orders with ChangeNotifier{
  List<OrderItem> _orders =[];
  final String authToken;
  final String userId;


  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
    //Creating a new copy of the list and sending so that our _orders is not editable outside the class 
  }


Future<void> fetchAndSetOrders()async {
  final url = Uri.parse('https://my-first-flutter-project-58c6e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
  final response = await http.get(url);
  final List<OrderItem> loadedOrders = [];
  final extractedData = json.decode(response.body) as Map<String, dynamic>;
  if(extractedData == null){
    return;
  }
  extractedData.forEach((orderId, orderData){
    loadedOrders.insert(0,OrderItem(
      id: orderId, 
      amount: orderData['amount'], 
      dateTime: DateTime.parse(orderData['dateTime']),
      products: (orderData['products'] as List<dynamic>).map((item) => CartItem(
        id: item['id'], 
        price: item['price'], 
        quantity: item['quantity'], 
        title: item['title']
        )
        ).toList(), 
      )
      );
  }
  );
  _orders = loadedOrders;
  notifyListeners();
  // print(json.decode(response.body));
}
  Future<void> addOrder(List<CartItem> cartProducts, double total) async{
      final url = Uri.parse('https://my-first-flutter-project-58c6e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
      final timestamp = DateTime.now();
      final response = await http.post(url,body: json.encode({
         'amount': total,
          //easily recreatable object of date and time
         'dateTime': DateTime.now().toIso8601String(),
         'products':cartProducts.map((cp) => {
          'id':cp.id,
          'title':cp.title,
          'quantity':cp.quantity,
          'price':cp.price,
         }).toList(),
      }
      )
      );

      //By using async this block is by default set into then block
     _orders.insert(0,OrderItem(
      id: json.decode(response.body)['name'], 
      amount: total, 
      products: cartProducts, 
      dateTime: DateTime.now(),
      ),
     );
     notifyListeners();
  }
}