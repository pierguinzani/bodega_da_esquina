import 'package:bodega_da_esquina/core/providers/orders_provider.dart';
import 'package:bodega_da_esquina/utils/view/theme_manager.dart';
import 'package:bodega_da_esquina/view/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:provider/provider.dart';
import '../../core/models/login_model.dart';
import '../../utils/view/constant_routs.dart';
import '../../utils/view/router.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/products_provider.dart';

class Home extends StatelessWidget {
  final LoginResponseModel user;
  Home({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        initialRoute: productsOverviewRoute,
        title: ThemeManager.appName,
        theme: ThemeManager.lightTheme,
        home: SharedBottomAppBar(
          user: user,
        ),
      ),
    );
  }
}
