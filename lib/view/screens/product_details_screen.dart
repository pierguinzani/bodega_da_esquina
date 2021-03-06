import 'package:bodega_da_esquina/core/providers/cart_provider.dart';
import 'package:bodega_da_esquina/core/providers/product_model_provider.dart';
import 'package:bodega_da_esquina/core/providers/products_provider.dart';
import 'package:bodega_da_esquina/utils/view/constant_routs.dart';
import 'package:bodega_da_esquina/view/shared/badge.dart';
import 'package:bodega_da_esquina/view/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final int index;

  ProductDetailsScreen({this.productId, this.index});
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findProductById(productId);

    // Listen to specific object
    return ChangeNotifierProvider.value(
      value: loadedProduct,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(loadedProduct.title,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
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
            Consumer<ProductModelProvider>(
              builder: (BuildContext context, ProductModelProvider value, _) {
                return IconButton(
                  icon: value.isFavorite
                      ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                      : Icon(Icons.favorite_border, color: Colors.grey[600]),
                  color: Theme.of(context).accentColor,
                  onPressed: value.changeFavoriteStatus,
                );
              },
            )
          ],
        ),
        body: ProductDetailsWidget(product: loadedProduct, index: index),
      ),
    );
  }
}
