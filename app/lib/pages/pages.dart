import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/contact.dart';
import 'package:customer_portal_app/pages/home.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:customer_portal_app/pages/meldenVertragswahl.dart';
import 'package:customer_portal_app/pages/news.dart';
import 'package:customer_portal_app/pages/vertraege.dart';
import 'package:flutter/material.dart';

class Pages {
  Pages(this.portal);

  final Portal portal;

  Widget get home => HomePage(
        reloadData: () async => await portal.reload(),
        newsPage: (onRefresh, bottomNavigationBar) =>
            news(onRefresh, bottomNavigationBar),
        vertraegePage: (onRefresh, bottomNavigationBar) =>
            vertraege(onRefresh, bottomNavigationBar),
        meldenPage: (onRefresh, bottomNavigationBar) =>
            meldenVertragswahl(onRefresh, bottomNavigationBar),
        kontaktPage: (onRefresh, bottomNavigationBar) =>
            kontakt(onRefresh, bottomNavigationBar),
      );

  Widget news(Future<void> Function() onRefresh, Widget bottomNavigationBar) =>
      NewsPage(
        key: UniqueKey(),
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
        logout: (context) async {
          await Portal.logout();
          WidgetsBinding.instance!.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            ),
          );
        },
      );

  Widget vertraege(
          Future<void> Function() onRefresh, Widget bottomNavigationBar) =>
      VertraegePage(
        portal,
        portal.vertraege,
        key: UniqueKey(),
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      );

  Widget meldenVertragswahl(
          Future<void> Function() onRefresh, Widget bottomNavigationBar) =>
      MeldenVertragwahlPage(
        portal,
        key: UniqueKey(),
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      );

  Widget kontakt(
          Future<void> Function() onRefresh, Widget bottomNavigationBar) =>
      ContactPage(
        key: UniqueKey(),
        portal: portal,
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      );
}
