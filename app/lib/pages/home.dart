import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/contact.dart';
import 'package:customer_portal_app/pages/meldenVertragswahl.dart';
import 'package:customer_portal_app/pages/news.dart';
import 'package:customer_portal_app/pages/vertraege.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage(this.portal, {Key? key}) : super(key: key);

  final Portal portal;

  @override
  _HomePageState createState() => _HomePageState(this.portal);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.portal);

  final Portal portal;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Future _reload() async {
    await portal.reload();
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
        return NewsPage(
          key: UniqueKey(),
          bottomNavigationBar: bottomNavigationBar,
          onRefresh: _reload,
        );
      case 1:
        return VertraegePage(
          portal,
          portal.vertraege,
          key: UniqueKey(),
          bottomNavigationBar: bottomNavigationBar,
          onRefresh: _reload,
        );
      case 2:
        return MeldenVertragwahlPage(
          portal,
          key: UniqueKey(),
          bottomNavigationBar: bottomNavigationBar,
          onRefresh: _reload,
        );
      case 3:
        return ContactPage(
          key: UniqueKey(),
          bottomNavigationBar: bottomNavigationBar,
          onRefresh: _reload,
        );
    }
    throw ("unknown tab index");
  }
}
