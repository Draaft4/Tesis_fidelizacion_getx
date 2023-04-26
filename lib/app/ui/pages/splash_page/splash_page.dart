
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/splash_controller.dart';


class SplashPage extends StatelessWidget {
  final SplashController _splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        background(),
        backgroundFilter(),
        content(),
      ]),
    );
  }

  Column content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16.0),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ))),
      ],
    );
  }

  BackdropFilter backgroundFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
        ),
      ),
    );
  }

  Container background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("static/splash.jpeg"), fit: BoxFit.cover),
      ),
    );
  }
}