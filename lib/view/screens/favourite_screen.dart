import 'package:bodega_da_esquina/core/providers/cart_provider.dart';
import 'package:bodega_da_esquina/utils/view/constant_routs.dart';
import 'package:bodega_da_esquina/view/shared/badge.dart';
import 'package:bodega_da_esquina/view/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  final _showFavouriteOnly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cartData, ch) {
              return Badge(
                value: cartData.itemsCount.toString(),
                child: ch,
                color: Colors.orange,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.grey[600]),
              onPressed: () {
                Navigator.pushNamed(context, cartScreenRoute);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showFavouriteOnly),
    );
  }
}
