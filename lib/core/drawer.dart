import 'package:cleanify/banksampah/page/mybanksampah.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/listbanksampah.dart';
import 'package:cleanify/banksampah/page/formbanksampah.dart';
import 'package:cleanify/laporsampah/page/form_report.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
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
          ),
          ListTile(
            title: const Text('Report'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FormReportPage()),
              );
            },
            dense: true,
          ),
          const ListTile(
            title: Text(
              'Waste Bank',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
          ),
          ListTile(
            title: const Text('List Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyBankSampahPage()),
              );
            },
            dense: true,
          ),
          ListTile(
            title: const Text('Form Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyFormPage()),
              );
            },
            dense: true,
          ),
          ListTile(
            title: const Text('My Bank Sampah'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BankSampahJson()),
              );
            },
            dense: true,
          ),
          const ListTile(
            title: Text(
              'FAQ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
          ),
          const ListTile(
            title: Text(
              'Blog',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
          ),
        ],
      ),
    );
  }
}
