import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_prototype/providers/products_provider.dart';
import 'package:shopping_app_prototype/widgets/app_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
              child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  UserProductItem(
                      productsData.items[index].id,
                      productsData.items[index].title,
                      productsData.items[index].imageUrl),
                  Divider(),
                ],
              );
            },
          ),
        ), onRefresh: () => _refreshProducts(context),
      ),
    );
  }
}
