import 'package:flutter/material.dart';
import 'package:pdf_app/styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text('pdf reader'),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () async {
        //     final prefs = await SharedPreferences.getInstance();
        //     prefs.setBool('showHome', false);
        //     print(prefs.get('showHome'));
        //   },
        // )
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 300,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Style.Donboarding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 48,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundImage:
                            AssetImage('assets/images/pdf-reader-logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'pdf reader',
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    Text('version 1.0.0',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.tertiary,
                        ))
                  ],
                ),
              ),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              title: const Text('Popular books'),
              onTap: () {
                // Navigator.popAndPushNamed(context, '/popularMedicine');
              },
            ),
            ListTile(
              style: ListTileStyle.drawer,
              title: const Text('Disclaimer'),
              onTap: () {
                // Navigator.popAndPushNamed(context, '/desclaimer');
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () {
                // Navigator.popAndPushNamed(context, '/privacyPolicy');
                // themeToogle();
              },
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () {
                // Navigator.popAndPushNamed(context, '/contactUs');
              },
            ),
            ListTile(
              title: const Text('About us'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(child: Text('home page')),
      ),
    );
  }
}
