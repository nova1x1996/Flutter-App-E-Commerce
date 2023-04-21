import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lab9_app_shopping/models/product_model.dart';
import 'package:lab9_app_shopping/providers/order_provider.dart';
import 'package:lab9_app_shopping/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class HistoryOrderPage extends StatefulWidget {
  static const routeName = "/historyOder";
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Order"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context).getListOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var model = snapshot.data as List;

          return (snapshot.hasData)
              ? ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (context, index1) {
                    var dataItem = model[index1];
                    var dataOrder_Items = dataItem['order_items'] as List;
                    return ExpansionTile(
                      title: Text('Mã đơn hàng ${dataItem['code']}',
                          style: TextStyle(fontSize: 19)),
                      subtitle: Text(
                        DateFormat('kk:mm - dd-MM-yyyy')
                            .format(DateTime.parse(dataItem['created_at'])),
                        style: TextStyle(fontSize: 16),
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dataOrder_Items.length,
                          itemBuilder: (context, index2) {
                            var modelItem = dataOrder_Items[index2];
                            return FutureBuilder(
                              future: Provider.of<ProductProvider>(context)
                                  .getProduct(modelItem['product_id']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                var modelProduct = snapshot.data as Product;
                                return ListTile(
                                  leading: Image.network(modelProduct.image),
                                  title: Text(modelProduct.name),
                                  subtitle: Text(
                                      "Quantity : ${modelItem['quantity']}"),
                                  trailing: Text(intl.NumberFormat
                                          .simpleCurrency(locale: 'vi')
                                      .format(
                                          double.parse(modelItem['amount']))),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                )
              : SvgPicture.asset("assets/images/svg/no-data.svg");
        },
      ),
    );
  }
}
