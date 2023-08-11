import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_app/styles.dart' as style;

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.Style.Donboarding,
      body: Overlay(
        initialEntries: [
          ///first overlay entry for  the background image
          OverlayEntry(builder: (context) {
            return Container(
                decoration: BoxDecoration(color: style.Style.Donboarding),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset(
                    "assets/images/pdf-reader-logo.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ));
          }),

          ///second overlay for the bottom container
          OverlayEntry(builder: (context) {
            return Column(
              verticalDirection: VerticalDirection.up,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .08,
                    width: MediaQuery.of(context).size.width,
                    color: style.Style.DPrimary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(children: [
                        Text(
                          'pdf reader',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Version 1.0.0',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                )
              ],
            );
          }),

          ///third overlay to create the swipe button animation
          OverlayEntry(builder: (context) {
            return Container();
          })
        ],
      ),
    );
  }
}
