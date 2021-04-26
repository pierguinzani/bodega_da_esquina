import 'package:bodega_da_esquina/view/screens/orders_screen.dart';
import 'package:bodega_da_esquina/view/screens/products_overview_screen.dart';
import 'package:bodega_da_esquina/view/shared/custom_bottomAppBar.dart';
import 'package:flutter/material.dart';

import '../../core/models/login_model.dart';
import '../screens/my_products_screen.dart';
import '../shared/custom_bottomAppBar.dart';

class SharedBottomAppBar extends StatefulWidget {
  final LoginResponseModel user;
  SharedBottomAppBar({Key key, @required this.user}) : super(key: key);
  @override
  _SharedBottomAppBarState createState() => _SharedBottomAppBarState(user);
}

class _SharedBottomAppBarState extends State<SharedBottomAppBar> {
  LoginResponseModel user;
  _SharedBottomAppBarState(this.user); //constructor
  Widget _lastSelected;
  List<Widget> pages;
  List<String> titles;
  List<BottomAppBarItem> bottomAppBar;

  @override
  void initState() {
    if (user.isAdmin) {
      _lastSelected = MyProductsScreen();
      pages = [
        OrdersScreen(),
        MyProductsScreen(),
      ];
      titles = ['Produtos', 'Pedidos da Loja'];
      bottomAppBar = [
        BottomAppBarItem(iconData: Icons.attach_money, text: 'Pedidos'),
        BottomAppBarItem(iconData: Icons.store, text: 'Produtos'),
      ];
    } else {
      _lastSelected = ProductsOverviewScreen();
      pages = [
        OrdersScreen(),
        //FavouriteScreen(),
        ProductsOverviewScreen(),
      ];
      titles = ['Meus pedidos', 'Home'];
      bottomAppBar = [
        //BottomAppBarItem(iconData: Icons.more_horiz, text: 'Nada AQui'),
        BottomAppBarItem(iconData: Icons.shopping_basket, text: 'Meus pedidos'),
        //BottomAppBarItem(iconData: Icons.favorite, text: 'Favourite'),
        BottomAppBarItem(iconData: Icons.shopping_cart, text: 'Shopping'),
      ];
    }
    super.initState();
  }

  void _selectedTab(int index) {
    setState(() {
      print(index);
      _lastSelected = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _lastSelected,
      bottomNavigationBar: CustomBottomAppBar(
        color: Colors.grey,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: bottomAppBar,
      ),
    );
  }
}
