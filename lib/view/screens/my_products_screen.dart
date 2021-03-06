import 'package:bodega_da_esquina/core/providers/product_model_provider.dart';
import 'package:bodega_da_esquina/core/providers/products_provider.dart';
import 'package:bodega_da_esquina/utils/view/constant_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos da Loja"),
      ),
      body: Stack(
        children: <Widget>[
          // Container(
          //     child: ListView.separated(
          //   itemBuilder: (ctx, index) {
          //     return productItem(productsData.products[index], context);
          //   },
          //   itemCount: productsData.products.length,
          //   separatorBuilder: (BuildContext context, int index) {
          //     return Divider(
          //       thickness: 0.8,
          //     );
          //   },
          // )),

          FutureBuilder<List<ProductModelProvider>>(
            future: productsData.products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return productItem(snapshot.data[index], context);
                  },
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 0.8,
                    );
                  },
                ));
              } else if (snapshot.hasError) {
                return Text("Error");
              }
              return Text("Carregando...");
            },
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25.0),
              child: FloatingActionButton(
                // color: Theme.of(context).accentColor,
                onPressed: () {
                  // Go to add product
                  Navigator.of(context)
                      .pushNamed(addEditProductScreenRoute, arguments: 'add');
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Draw productItem
  Widget productItem(ProductModelProvider product, BuildContext context) {
    return ListTile(
      title: Text(product.title, style: Theme.of(context).textTheme.headline6),
      subtitle: Text(
        product.description,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[500],
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        radius: 24,
      ),
      trailing: Text(
        product.price.toString(),
      ),
      onTap: () {
        // Go to edit product
        Navigator.of(context)
            .pushNamed(addEditProductScreenRoute, arguments: product.id);
      },
    );
  }
}
