import 'package:flutter/material.dart';
import 'package:lab9_app_shopping/page/product/product.dart';
import 'package:lab9_app_shopping/providers/cate_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import '../../../models/product_model.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({
    super.key,
  });

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  late Future listModel;

  @override
  void didChangeDependencies() {
    var paramRoute = ModalRoute.of(context)?.settings.arguments as Map;

    listModel = Provider.of<CategoryProvider>(context, listen: false)
        .getProductInCategory(paramRoute["id"]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listModel,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error "),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var model = snapshot.data as List<Product>;

        return (snapshot.hasData)
            ? GridView.builder(
                padding: EdgeInsets.all(15),
                itemCount: model.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 230),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ProductPage.routerName,
                          arguments: {
                            "data": model[index],
                          });
                    },
                    child: GridTile(
                      footer: Container(
                        height: 60,
                        child: GridTileBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model[index].name.length > 13
                                        ? model[index]
                                            .name
                                            .substring(0, 13)
                                            .toString()
                                        : model[index].name,
                                    style: TextStyle(
                                      fontSize: 17,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Text(
                                    model[index].summary.length > 14
                                        ? model[index]
                                            .summary
                                            .substring(0, 14)
                                            .toString()
                                        : model[index].summary,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    intl.NumberFormat.simpleCurrency(
                                            locale: 'vi', decimalDigits: 0)
                                        .format(model[index].price),
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.amber[300]),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.shopping_cart,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          model[index].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text("No Data"),
              );
      },
    );
  }
}
