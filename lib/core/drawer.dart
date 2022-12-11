import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/authentication/page/loginPage.dart';
import 'package:cleanify/faq/page/faqPage.dart';
import 'package:cleanify/banksampah/page/my.dart';
import 'package:cleanify/blog/page/index.dart';
import 'package:cleanify/main.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/list.dart';
import 'package:cleanify/banksampah/page/form.dart';
import 'package:cleanify/laporsampah/page/form_report.dart';
import 'package:cleanify/laporsampah/page/list_report.dart';
import 'package:provider/provider.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';

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
    final request = context.watch<CookieRequest>();
    final user = context.watch<User>();

    Future<void> Logout(BuildContext context) async {
      const url = "https://cleanifyid.up.railway.app/auth/api/logout";
      final response = await request.logout(url);
      print(response);
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Successfully logged out!"),
        ));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An error occured, please try again."),
        ));
      }
    }

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text(user.role == "anonymous" ? "Anonymous" : user.name ?? ""),
            accountEmail: Text(user.role == "anonymous"
                ? "Click to log in."
                : user.email ?? ""),
            onDetailsPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded)
            ListTile(
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
                      )),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text('Cleanify',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color))),
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
            title: Text('Report Waste',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
            dense: true,
          ),
          ListTile( // Both user and crew access
            title: const Text('Report Location'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FormReportPage()),
              );
            },
          ),
          ListTile( // Crew access
            title: const Text('View Locations'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ListReportPage()),
              );
            },
          ),
          const ListTile(
            title: Text('Waste Bank',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
            dense: true,
          ),
          ListTile(
            title: const Text('List Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BankSampahMyPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Form Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BankSampahFormPage()),
              );
            },
          ),
          ListTile(
            title: const Text('My Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BankSampahJsonPage()),
              );
            },
          ),
          const ListTile(
            title: Text('FAQ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
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
            title: Text('Blog',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
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
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              Logout(context);
            },
          ),
        ],
      ),
    );
  }
}
