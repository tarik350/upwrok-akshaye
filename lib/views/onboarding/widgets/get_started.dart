import 'package:flutter/material.dart';
import 'package:pdf_app/views/authenthication/login_page.dart';
import 'package:pdf_app/views/pdf_viewer_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).iconTheme.color),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                //we will look into this warning
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Get Started'),
              )),
        ),
      ],
    );
  }
}
