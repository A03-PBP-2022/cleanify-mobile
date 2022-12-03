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


final Uri _url = Uri.parse('https://cleanifyid.up.railway.app');

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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              alignment: Alignment.center,
              color: Theme.of(context).backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.delete,
                            size: 64,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          )
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            'Cleanify',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: Theme.of(context).textTheme.bodyMedium?.color
                            )
                          )
                        ),
                        
                      ],
                    ),
                  ),
                  const Text(
                    'An app to clean the trash around us.'
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Cleanify menawarkan jasa untuk membantu membersihkan sampah di sekitar kita. Aplikasi ini memudahkan masyarakat untuk menjaga lingkungan yang lebih bersih lagi. Aplikasi ini juga mempunyai tujuan untuk meningkatkan awareness masyarakat terhadap lingkungan sekitar.',
                style: TextStyle(
                  height: 1.5
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Anda dapat mulai aplikasi ini dengan membuka drawer disamping.',
                style: TextStyle(
                  height: 1.5
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Cleanify juga tersedia dalam ",
                    ),
                    TextSpan(
                      text: "cleanifyid.up.railway.app",
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
                ),
                style: const TextStyle(
                  height: 1.5
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
