import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouritesOnly = false;
  var _isLoading = false;


  @override
  void initState() {
    setState(() {
    _isLoading = true;
    });
    Provider.of<Products>(context,listen: false).fetchAndSetProducts().then((_) {
     
     setState(() {
      _isLoading = false;
       
     });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
  //final productsContainer =Provider.of<Products>(context, listen: false);
    
    
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              //print('selected value');
               setState(() {
                 
              if(selectedValue == FilterOptions.Favourites){
                //productsContainer.showFavouritesOnly();
                _showFavouritesOnly = true;
              }
              else{
                _showFavouritesOnly = false;
                //productsContainer.showAll();
              }
               });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favourites'),value: FilterOptions.Favourites),
              PopupMenuItem(child: Text('Show All'),value: FilterOptions.All),
            ] , 
            ),
            Consumer <Cart> (
              builder: (_,cart,ch) =>  Badge(
              child: ch,
              value: cart.itemCount.toString()
              ),
              //This is not rebuild rather it is recycled
              child: IconButton(
              icon:Icon(Icons.shopping_cart
              ),
              onPressed: (() {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }
              )  
              )   
            ) 
        ],
      ),
      body: _isLoading?Center(
        child: CircularProgressIndicator(),
      )
      :ProductsGrid(_showFavouritesOnly),
    );
  }
}

