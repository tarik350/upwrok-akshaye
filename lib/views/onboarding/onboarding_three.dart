import 'package:flutter/material.dart';
import 'package:pdf_app/styles.dart';

class OnboeardingThree extends StatefulWidget {
  const OnboeardingThree({super.key});

  @override
  State<OnboeardingThree> createState() => _OnboeardingThreeState();
}

class _OnboeardingThreeState extends State<OnboeardingThree>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Donboarding,

      ///the entire widget starts here
      body: Center(
        ///sized box to give the page consistant width
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ///the logo
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ///everthing under the logo
                    FittedBox(
                      child: Column(
                        children: [
                          /// the text beneth the logo

                          Text(
                            'All your book needs',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Answered',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //the three dots to indicate page navigation

                    SizedBox(
                      height: 40,
                    ),
                    // the button  at the bottom of the page to navigate to home page
                  ],
                ),
                Container(
                  height: 40,
                )
              ]),
        ),
      ),
    );
  }
}

Widget dotContainer() {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
  );
}
