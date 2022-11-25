import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = 'Cleanify';

  @override
  State<HomePage> createState() => _HomePageState();
}


final Uri _url = Uri.parse('https://cleanifyid.herokuapp.com');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Menambahkan drawer menu
      drawer: const GlobalDrawer(),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Coming soon!',
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "For now, we're available at ",
                    ),
                    TextSpan(
                      text: "cleanifyid.herokuapp.com",
                      style: const TextStyle(
                        color: Colors.blue, 
                        decoration: TextDecoration.underline
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _launchUrl,
                    ),
                    const TextSpan(
                      text: ".",
                    ),
                  ],
                  style: const TextStyle(color: Colors.black87, fontFamily: 'Roboto')
                ),
              )
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }
}
