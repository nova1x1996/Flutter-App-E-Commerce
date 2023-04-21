import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lab9_app_shopping/models/product_model.dart';
import 'package:lab9_app_shopping/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';

class HomeSpecial extends StatelessWidget {
  const HomeSpecial({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProductProvider>(context).getProductsSpecial(),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text("No data"),
          );
        }
        List<Product> listModel = snapshot.data as List<Product>;
        return Expanded(
          flex: 1,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 70,
                  child: Image.network(
                    listModel[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  listModel[index].name,
                  style: TextStyle(fontSize: 19),
                  maxLines: 2,
                ),
                subtitle: Text(
                  intl.NumberFormat.simpleCurrency(
                    locale: 'vi',
                  ).format(listModel[index].price),
                  style: TextStyle(fontSize: 17),
                ),
                trailing: InkWell(
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false).addCart(
                        listModel[index].id,
                        listModel[index].image,
                        listModel[index].name,
                        listModel[index].price,
                        1);
                  },
                  child: Icon(
                    Icons.shopping_cart_checkout,
                    size: 30,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.black,
              );
            },
            itemCount: listModel.length,
          ),
        );
      },
    );
  }
}
