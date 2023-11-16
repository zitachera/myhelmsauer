import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:flutter/material.dart';

typedef PageFunc = Widget Function(Future<void> Function() onRefresh, Widget bottomNavigationBar);

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.reloadData,
    required this.newsPage,
    required this.vertraegePage,
    required this.meldenPage,
    required this.bestandVerzeichnisPage,
    required this.kontaktPage,
  });
  final Future<void> Function() reloadData;
  final PageFunc newsPage;
  final PageFunc vertraegePage;
  final PageFunc meldenPage;
  final PageFunc bestandVerzeichnisPage;
  final PageFunc kontaktPage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Future _reload() async {
    await widget.reloadData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/home.svg"),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/vertrag.svg"),
          label: 'Vertrag',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(
            "images/menu/schaden.svg",
            color: Colors.red,
          ),
          label: 'Schaden',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/verzeichnis.svg"),
          label: 'Verzeichnis',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/kontakt.svg"),
          label: 'Kontakt',
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      selectedItemColor: helmsauerBlau,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
    switch (_selectedIndex) {
      case 0:
        return widget.newsPage(_reload, bottomNavigationBar);
      case 1:
        return widget.vertraegePage(_reload, bottomNavigationBar);
      case 2:
        return widget.meldenPage(_reload, bottomNavigationBar);
      case 3:
        return widget.bestandVerzeichnisPage(_reload, bottomNavigationBar);
      case 4:
        return widget.kontaktPage(_reload, bottomNavigationBar);
    }
    throw ("unknown tab index");
  }
}
