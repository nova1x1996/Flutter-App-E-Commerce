import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lab9_app_shopping/models/slider_model.dart';
import 'package:lab9_app_shopping/providers/slider_provider.dart';

import 'package:provider/provider.dart';

class HomeSlide extends StatefulWidget {
  const HomeSlide({super.key});

  @override
  State<HomeSlide> createState() => _HomeSlideState();
}

class _HomeSlideState extends State<HomeSlide> {
  late Future sliderFuture;

  @override
  void initState() {
    super.initState();
    sliderFuture =
        Provider.of<SliderProvider>(context, listen: false).getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: FutureBuilder(
        initialData: const [],
        future: sliderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          var listSlider = snapshot.data as List;
          return snapshot.hasData
              ? CarouselSlider(
                  options: CarouselOptions(height: 200.0, autoPlay: true),
                  items: listSlider.map((e) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(e.image))),
                        );
                      },
                    );
                  }).toList(),
                )
              : Text("No Data");
        },
      ),
    );
  }
}
