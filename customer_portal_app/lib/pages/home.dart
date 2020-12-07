import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/pages/meldenVertragswahl.dart';
import 'package:customer_portal_app/pages/news.dart';
import 'package:customer_portal_app/pages/vertraege.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _content = NewsPage();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _content = NewsPage();
          break;
        case 1:
          _content = VertraegePage();
          break;
        case 2:
          _content = MeldenVertragwahlPage();
          break;
        case 3:
        // TODO Kontakt
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Helmsauer',
      body: _content,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Verträge',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            label: 'Schadenmeldung',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Kontakt',
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  FlatButton _buildVertrag(BuildContext context, Vertrag vertrag) {
    return FlatButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VertragPage(vertrag: vertrag)),
        ),
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              vertrag.sparte,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vertrag.gesellschaft,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vertrag.vertragsnummer,
              textScaleFactor: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
