import 'package:flutter/material.dart';
import '../providers/orders.dart'show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var _isLoading = false;
  //
  Future _ordersFuture;
  //For ensuring that no unnecessary http requests are sent to the server during state changes if build is called multiple times although here buid is not called multiple times.
  Future _obtainOrdersFuture () {
    return Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("printing orders");
    // final orderData =Provider.of<Orders>(context);
    // final url = Uri.parse('https://my-first-flutter-project-58c6e-default-rtdb.firebaseio.com/orders.json');
    // orderData.orders.forEach((orderItem) {
    //   http.post(url,
    //   body:json.encode(
    //     {
    //      ''
    //     }
    //   ));
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if(dataSnapshot.connectionState == ConnectionState.waiting){
            return Center(
           child: CircularProgressIndicator(),
         );
          }
          else if(dataSnapshot.error !=null){
            //Do the error handling stuff
            return Center(child: Text("An error occured!"),);
          }
          else{
           return Consumer<Orders>(
            builder: (context, orderData, child) => ListView.builder(
            itemBuilder: (context, index) => OrderItem(orderData.orders[index]
             ),
             itemCount: orderData.orders.length,
            ),
           );
        }
        },
        ) 
    );
  }
}