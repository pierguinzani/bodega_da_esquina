import 'package:bodega_da_esquina/core/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String itemId;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartItemWidget({
    this.itemId,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(itemId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem certeza?'),
            content: Text('Você quer remover esse item do carrinho?'),
            actions: <Widget>[
              TextButton(
                child: Text('NÃO'),
                onPressed: () {
                  // false mean we want not to confirm the dismiss
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  // false mean we want to confirm the dismiss
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // Using Provider.of not Consumer because Provider.of work as a method
        Provider.of<CartProvider>(context, listen: false)
            .removeItemFromCart(itemId);
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text(': \R\$ ${(price * quantity).toStringAsFixed(2)}'),
              trailing: Text('$quantity x'),
            ),
            Divider(
              thickness: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
