import 'package:bodega_da_esquina/core/providers/cart_provider.dart';
import 'package:bodega_da_esquina/core/providers/orders_provider.dart';
import 'package:bodega_da_esquina/view/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\R\$ ${cart.totalPriceAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  TextButton(
                    child: Text('Finalizar compra'),
                    onPressed: () {
                      // Listen to OrdersProvider
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(
                        cart.cartItems.values.toList(),
                        cart.totalPriceAmount,
                      );
                      cart.clearCart();
                    },
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                itemId: cart.cartItems.keys.toList()[i], // CartItem id
                productId: cart.cartItems.values.toList()[i].id,
                price: cart.cartItems.values.toList()[i].price,
                quantity: cart.cartItems.values.toList()[i].quantity,
                title: cart.cartItems.values.toList()[i].title,
                imageUrl: cart.cartItems.values.toList()[i].imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
