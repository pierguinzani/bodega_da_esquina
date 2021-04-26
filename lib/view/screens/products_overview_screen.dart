import 'package:bodega_da_esquina/core/providers/cart_provider.dart';
import 'package:bodega_da_esquina/utils/view/constant_routs.dart';
import 'package:bodega_da_esquina/view/shared/badge.dart';
import 'package:bodega_da_esquina/view/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bodega da Esquina'),
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
          // PopupMenuButton(
          //   onSelected: (FilterOptions option) {
          //     setState(() {
          //       if (option == FilterOptions.Favourites) {
          //         _showFavouriteOnly = true;
          //       } else {
          //         _showFavouriteOnly = false;
          //       }
          //     });
          //   },
          //   icon: Icon(Icons.more_vert, color: Colors.grey[600]),
          //   itemBuilder: (ctx) {
          //     return [
          //       PopupMenuItem(
          //         child: Text('Somente Favoritos'),
          //         value: FilterOptions.Favourites,
          //       ),
          //       PopupMenuItem(
          //         child: Text('Mostrar todos'),
          //         value: FilterOptions.All,
          //       ),
          //     ];
          //   },
          // ),
        ],
      ),
      body: ProductsGrid(_showFavouriteOnly),
    );
  }
}
