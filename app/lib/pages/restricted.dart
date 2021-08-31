import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/contact.dart';
import 'package:customer_portal_app/pages/meldenVertragswahl.dart';
import 'package:customer_portal_app/pages/news.dart';
import 'package:flutter/material.dart';

class RestrictedPage extends StatefulWidget {
  RestrictedPage(this.portal, {Key? key}) : super(key: key);

  final Portal portal;

  @override
  _RestrictedPageState createState() {
    portal.vertraege.removeWhere((v) => v.spartenID != "KFZ");
    return _RestrictedPageState(this.portal);
  }
}

class _RestrictedPageState extends State<RestrictedPage> {
  _RestrictedPageState(this.portal);

  final Portal portal;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget get _content {
    switch (_selectedIndex) {
      case 0:
        return NewsPage(
          key: UniqueKey(),
        );
      case 1:
        return MeldenVertragwahlPage(
          portal,
          key: UniqueKey(),
        );
      case 2:
        return ContactPage(
          key: UniqueKey(),
        );
    }
    throw ("unknown tab index");
  }

  Future _reload() async {
    await portal.reload();
    portal.vertraege.removeWhere((v) => v.spartenID != "KFZ");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Helmsauer',
      body: _content,
      onRefresh: _reload,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgIcon("images/menu/home.svg"),
            label: 'Home',
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
      ),
    );
  }
}
