import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'controller/controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return Stack(
              children: [
                Image.asset(
                  'assets/bg/first_bg.png',
                  width: width,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/loading.png'),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/load_container.png',
                            width: 200,
                          ),
                          Positioned(
                            width: 152,
                            height: 27,
                            child: AnimatedBuilder(
                              animation: controller.controller,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: controller.progressValue,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF0878CD),
                                          Color(0xFFD50569),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Image.asset('assets/images/please_wait.png'),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
