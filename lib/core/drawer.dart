import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/authentication/page/loginPage.dart';
import 'package:cleanify/faq/page/faqPage.dart';
import 'package:cleanify/banksampah/page/my.dart';
import 'package:cleanify/blog/page/index.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/list.dart';
import 'package:cleanify/banksampah/page/form.dart';
// import 'package:cleanify/laporsampah/page/form_report.dart';
// import 'package:cleanify/laporsampah/page/list_report.dart';
import 'package:cleanify/laporsampah/page/formtwo.dart';
import 'package:cleanify/laporsampah/page/listtwo.dart';
import 'package:provider/provider.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalDrawer extends StatefulWidget {
  const GlobalDrawer({super.key});

  final String title = 'Cleanify';

  @override
  State<GlobalDrawer> createState() => _GlobalDrawerState();
}
class _GlobalDrawerState extends State<GlobalDrawer> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.role == "anonymous" ? "Anonymous" : user.name ?? ""), 
            accountEmail: Text(user.role == "anonymous" ? "Click to log in." : user.email ?? ""),
            onDetailsPressed:() {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded) ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            dense: true,
          ),
          ListTile(
            title: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.delete,
                      size: 32,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    )
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                      'Cleanify',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyMedium?.color
                      )
                    )
                  ),
                  
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          const ListTile(
            title: Text(
              'Report Waste',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
            dense: true,
          ),
          ListTile(
            title: const Text('Pelaporan Wilayah Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FormReportPage()),
              );
            },
          ),
          ListTile(
            title: const Text('List Wilayah Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ListReportPage()),
              );
            },
          ),
          const ListTile(
            title: Text(
              'Waste Bank',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
            dense: true,
          ),
          ListTile(
            title: const Text('List Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BankSampahMyPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Form Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BankSampahFormPage()),
              );
            },
          ),
          ListTile(
            title: const Text('My Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BankSampahJsonPage()),
              );
            },
          ),
          const ListTile(
            title: Text(
              'FAQ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
            dense: true,
          ),
          ListTile(
            title: const Text('FAQ'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FaqPage()),
              );
            },
          ),
          const ListTile(
            title: Text(
              'Blog',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
            dense: true,
          ),
          ListTile(
            title: const Text('Index'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BlogIndexPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
