import 'package:flutter/foundation.dart';
import '../widgets/cart_item.dart';


class CartItem {
final String id;
final String title;
final int quantity;
final double price;

CartItem({
  @required this.id,
  @required this.price,
  @required this.quantity,
  @required this.title,
});

}



class Cart with ChangeNotifier{
   
   int get itemCount {
     return _items.length;
   }
   
   Map<String ,CartItem> _items = {} ;

   Map<String, CartItem> get items{
    return {..._items};
   }
   
   
   double get totalAmount {
    var total =0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
     }
     );
     return total;
   }

   void addItem(String productId,double price, String title){
     if(_items.containsKey(productId)){
      //change quantity
      _items.update(productId, (existingCartItem) => CartItem(
        id: existingCartItem.id,
        price: existingCartItem.price, 
        quantity: existingCartItem.quantity + 1, 
        title: existingCartItem.title)
        );
     }
     else{
      _items.putIfAbsent(productId, 
      () => CartItem(
      id: DateTime.now().toString(),
      title: title,
      price: price,
      quantity: 1
      ),
      );
     }
     notifyListeners();
   }
   
   void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
   }
   
   void clear() {
    _items = {};
    notifyListeners();
   }

   void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity > 1){
      _items.update(productId, 
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        title: existingCartItem.title,
        price:existingCartItem.price,
        quantity:existingCartItem.quantity -1
      )
      );
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
   }
}