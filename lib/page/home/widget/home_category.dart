import 'package:flutter/material.dart';
import 'package:lab9_app_shopping/constant/constant.dart';
import 'package:lab9_app_shopping/page/category/category.dart';
import 'package:lab9_app_shopping/providers/cate_provider.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({
    super.key,
  });

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late Future listCate;
  @override
  void didChangeDependencies() {
    listCate = Provider.of<CategoryProvider>(context).getCategory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listCate,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        var model = snapshot.data as List;
        return (snapshot.hasData)
            ? SizedBox(
                height: 90,
                child: ListView.separated(
                    itemCount: model.length,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CategoryPage.router,
                              arguments: {
                                "id": model[index].id,
                                "name": model[index].name,
                              });
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: 70,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: dColorxam,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.network(
                                model[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              model[index].name,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 35,
                      );
                    }),
              )
            : Text("Don't have Data");
      },
    );
  }
}
