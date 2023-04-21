import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:lab9_app_shopping/models/product_model.dart';
import 'package:intl/intl.dart' as intl;

class ProductPage extends StatelessWidget {
  static const routerName = "/product";
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    var paramRoute = ModalRoute.of(context)?.settings.arguments as Map;
    Product product = paramRoute["data"];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 55),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  )),
              title: Text(
                product.name,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    product.description,
                    maxLines: 14,
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: Icon(Icons.remove)),
                        const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "1",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add Product",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
