import 'package:flutter/material.dart';
import '../screens/edit_products_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';


class UserProductItem extends StatelessWidget {
  
  final String id;
  final String title;
  final String imageUrl;
  //final Function deleteHandler;


  UserProductItem(this.id,this.title,this.imageUrl);

  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed:() {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id
                  );
              }, 
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              ),
            IconButton(
              onPressed:() async{
                try { 
                await Provider.of<Products>(context,listen: false).deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting Failed!')
                      )
                      );
                }
              }, 
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              ),

          ],
        ),
      ),
    );
  }
}