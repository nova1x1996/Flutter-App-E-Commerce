import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab9_app_shopping/helper/alert.dart';
import 'package:lab9_app_shopping/providers/cart_provider.dart';
import 'package:lab9_app_shopping/providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class CartPage extends StatefulWidget {
  static const routeName = "/cart";
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void HandleOder() {
    var items = Provider.of<CartProvider>(context, listen: false).items;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertLoading;
      },
    );

    Future.delayed(
      Duration(seconds: 3),
      () {
        Provider.of<OrderProvider>(context, listen: false).buy(items).then(
          (value) {
            if (value == true) {
              Provider.of<CartProvider>(context, listen: false).removeCart();
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => alertSuccess,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<CartProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: (cartItems.isNotEmpty)
          ? Stack(children: [
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  var listModel = value.items.values.toList();

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var model = listModel[index];
                      return ListTile(
                        leading: Image.network(
                          model.image,
                          fit: BoxFit.contain,
                          width: 80,
                          height: 80,
                        ),
                        title: Text(
                          model.name,
                          maxLines: 2,
                          style: TextStyle(fontSize: 19),
                        ),
                        subtitle: Text(
                          intl.NumberFormat.simpleCurrency(
                                  decimalDigits: 0, locale: 'vi')
                              .format(model.price),
                          style: TextStyle(fontSize: 17),
                        ),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  value.decrease(model.id);
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 27,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(model.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.blue)),
                              ),
                              InkWell(
                                onTap: () {
                                  value.increase(model.id);
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 27,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: listModel.length,
                  );
                },
              ),
              Positioned(
                  bottom: 0,
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  left: 0,
                  child: ElevatedButton(
                      onPressed: () {
                        HandleOder();
                      },
                      child: Text(
                        "Order",
                        style: TextStyle(fontSize: 24),
                      )))
            ])
          : Container(
              child: Center(
                  child: SvgPicture.asset("assets/images/svg/no-data.svg")),
            ),
    );
  }
}
