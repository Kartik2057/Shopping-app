import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart; 
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context); 
    
    return Scaffold(
     appBar: AppBar(
      actions: [],
      title: Text('Your Cart'),
      ),
      body: Column(children: <Widget>[
        Card(margin: 
        EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Total',
              style: TextStyle(fontSize: 20),
              ),
              Spacer(),
             // SizedBox(width: 10,),
              Chip(
                label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodySmall.color 
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                ),
                OrderButton(cart: cart)
            ],
          ) 
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) => CartItem(
              cart.items.values.toList()[index].id,
              cart.items.keys.toList()[index], 
              cart.items.values.toList()[index].price, 
              cart.items.values.toList()[index].quantity, 
              cart.items.values.toList()[index].title
              )
              ),
            itemCount: cart.itemCount,
            )
          )
      ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(  
    onPressed: (widget.cart.totalAmount <=0 || _isLoading) ?null:(() async{
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context,listen: false).addOrder(widget.cart.items.values.toList(), 
        widget.cart.totalAmount);
        widget.cart.clear();
        setState(() {
        _isLoading = false;
        });
      }
      ),  
    child: _isLoading?Center(child: CircularProgressIndicator(),
    ):Text('ORDER NOW'),
    style: TextButton.styleFrom(
      foregroundColor: Theme.of(context).primaryColor,
    )
    );
  }
}