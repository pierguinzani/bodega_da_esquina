import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bodega_da_esquina/core/providers/login_provider.dart'
    as Globals;
import 'package:bodega_da_esquina/core/providers/product_model_provider.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModelProvider> _products = [
    ProductModelProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductModelProvider(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://i.shgcdn.com/6f18c86f-f2b7-4c90-a21d-0c3cd3ff8ade/-/format/auto/-/preview/3000x3000/-/quality/lighter/'),
    ProductModelProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://www.pngarts.com/files/3/Men-Jacket-Download-Transparent-PNG-Image.png',
    ),
    ProductModelProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    ProductModelProvider(
        id: 'p5',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://webcomicms.net/sites/default/files/clipart/170435/clothes-png-transparent-images-170435-4237336.png'),
    ProductModelProvider(
        id: 'p6',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://toppng.com/uploads/preview/1st-in-firefighter-bear-pocket-t-black-firefighter-what-teddy-bear-clothes-fits-most-115690366871syjjukhtr.png'),
    ProductModelProvider(
        id: 'p7',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://produtos.fotos-riachuelo.com.br/media/catalog/product/cache/3541e153ef6ead3044d72626c3847968/c/a/camiseta-basica-branco-12292605_foto1_frontal.jpg'),
    ProductModelProvider(
      id: 'p8',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://img.favpng.com/15/5/21/1950s-dress-halterneck-clothing-polka-dot-png-favpng-CVsvfuuL83smqtH6b23jFVrLz.jpg',
    ),
  ];

  Future<List<ProductModelProvider>> get products async {
    String url = "https://restful-ecommerce-ufma.herokuapp.com/api/v1/products";

    final response = await http.get(url);
    final responseJson = jsonDecode(response.body);
    _products = List<ProductModelProvider>.from(
        responseJson["data"].map((x) => ProductModelProvider.fromJson(x)));
    return _products;
  }

  // getter
  //  List<Product> get products => [..._products];
  // List<ProductModelProvider>  get products {
  //   getproducts();
  //   return _products;
  // }

  List<ProductModelProvider> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  Future<void> addProduct(ProductModelProvider product) {
    const String url =
        "https://restful-ecommerce-ufma.herokuapp.com/api/v1/products";
    return http
        .post(url,
            headers: {
              'authorization': Globals.GlobalData.token,
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price.toInt(),
              'imageUrl': product.imageUrl,
              //'isFavorite': product.isFavorite,
            }))
        .then((response) {
      print(response);
      _products.add(product);
      notifyListeners();
    }).catchError((err) {
      // Print Something ...
    });
  }

  void updateProduct(String id, ProductModelProvider product) {
    final productIndex = _products.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      _products[productIndex] = product;
      notifyListeners();
    }
  }

  // void deleteProduct(String id) {
  //   _products.removeWhere((prod) => prod.id == id);
  //   notifyListeners();
  // }

  Future<void> deleteProduct(String id) {
    String url =
        "https://restful-ecommerce-ufma.herokuapp.com/api/v1/products/" + id;
    return http.delete(
      url,
      headers: {
        'authorization': Globals.GlobalData.token,
        'Content-Type': 'application/json',
      },
    ).then((response) {
      print(response);
      _products.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }).catchError((err) {
      // Print Something ...
    });
  }

  ProductModelProvider findProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void addProductToFavourite(String id) {
    final product = _products.firstWhere((product) => product.id == id);
    if (product.isFavorite == false) {
      product.isFavorite = true;
      notifyListeners();
    }
  }

  void removeProductFromFavourite(String id) {
    final product = _products.firstWhere((product) => product.id == id);
    if (product.isFavorite) {
      product.isFavorite = false;
      notifyListeners();
    }
  }
}
