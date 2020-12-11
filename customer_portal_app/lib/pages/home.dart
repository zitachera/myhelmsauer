import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/pages/contact.dart';
import 'package:customer_portal_app/pages/meldenVertragswahl.dart';
import 'package:customer_portal_app/pages/news.dart';
import 'package:customer_portal_app/pages/vertraege.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _content = NewsPage(
    key: UniqueKey(),
  );
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _content = NewsPage(
            key: UniqueKey(),
          );
          break;
        case 1:
          _content = VertraegePage(
            key: UniqueKey(),
          );
          break;
        case 2:
          _content = MeldenVertragwahlPage(
            key: UniqueKey(),
          );
          break;
        case 3:
          _content = ContactPage(
            key: UniqueKey(),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Helmsauer',
      body: _content,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Vertrag',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            label: 'Schaden',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Kontakt',
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: helmsauerBlue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
