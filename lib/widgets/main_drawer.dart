import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';
import '../helpers/custom_route.dart';

class MainDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            //So that there is no option of returning to the previous page
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (() {
              Navigator.of(context).pushNamed('/');
            }
            ),
            ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (() {
              Navigator.of(context).pushNamed('/orders');
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => OrdersScreen(),
              //     )
              //   );
            }
            ),
            ),
            Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: (() {
              Navigator.of(context).pushNamed('/user-products');
            }
            ),
            ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (() {
              Navigator.of(context).pop();
              //Going to the home route
              Navigator.of(context).pushReplacementNamed('/');
              // Navigator.of(context).pushNamed('/user-products');
              Provider.of<Auth>(context, listen: false).logout();
            }
            ),
            ),
          

        ],
      ),
    );
  }
}