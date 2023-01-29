import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './products_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  
  final bool _showFav;

  ProductsGrid(this._showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =  _showFav  
    ?productsData.favouriteItems
    :productsData.items;


    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        ), 
      itemBuilder: (cont, index) =>
         ChangeNotifierProvider.value(
          //create: (c) => products[index],
          value:products[index],
          child:ProductItem()
          // products[index].id,
          // products[index].imageUrl,
          // products[index].title,
         )
    );
  }
}