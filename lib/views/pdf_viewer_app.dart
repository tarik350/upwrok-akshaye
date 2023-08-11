import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pdf_app/styles.dart';
import 'package:pdf_app/views/home.dart';
import 'package:pdf_app/views/userProfile.dart';

class PdfViewerApp extends StatefulWidget {
  const PdfViewerApp({Key? key}) : super(key: key);

  @override
  State<PdfViewerApp> createState() => _PdfViewerAppState();
}

class _PdfViewerAppState extends State<PdfViewerApp> {
  int _selectedIndex = 0;
  List<Widget> widgets = [Home(), UserProfile()];

  ////

  @override
  void initState() {
    super.initState();
    // globalBloc = GlobalBloc();
    // _pageController = PageController();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(color: Style.DPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            iconSize: 24,
            duration: const Duration(milliseconds: 200),
            tabBackgroundColor: Colors.grey[200]!,
            color: Colors.white,
            activeColor: Style.DPrimary,
            tabs: [
              GButton(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2,
                    vertical: 10),
                icon: Icons.home,
                semanticLabel: "home",
              ),
              GButton(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2,
                    vertical: 10),
                icon: Icons.camera,
                semanticLabel: "user",
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      body: Center(child: widgets.elementAt(_selectedIndex)),
    );
  }
}
