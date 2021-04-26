import 'package:bodega_da_esquina/core/providers/products_provider.dart';
import 'package:bodega_da_esquina/view/widgets/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/product_model_provider.dart';

class ProductsGrid extends StatelessWidget {
  final showFavorites;
  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    // listen to ProductsProvider to get all products list
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.products;
    //showFavorites ? productsData.favoriteProducts : productsData.products;
    // return GridView.builder(
    //     itemCount: products.length,
    //     padding: const EdgeInsets.all(10.0),
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2, // Number of items in row
    //       childAspectRatio: 0.75,
    //       crossAxisSpacing: 10.0, // Space between columns
    //       mainAxisSpacing: 15, // Space between rows
    //     ),
    //     itemBuilder: (context, index) {
    //       // Listen to specific object
    //       return ChangeNotifierProvider.value(
    //         value: products[index],
    //         child: ProductGridItem(index),
    //       );
    //     });
    return Scaffold(
      body: FutureBuilder<List<ProductModelProvider>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items in row
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10.0, // Space between columns
                  mainAxisSpacing: 15, // Space between rows
                ),
                itemBuilder: (context, index) {
                  // Listen to specific object
                  return ChangeNotifierProvider.value(
                    value: snapshot.data[index],
                    child: ProductGridItem(index),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Text("Loading...");
        },
      ),
    );
  }
}
