import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:customer_portal_app/pages/addFremdvertrag.dart';
import 'package:customer_portal_app/pages/contact.dart';
import 'package:customer_portal_app/pages/file.dart';
import 'package:customer_portal_app/pages/home.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:customer_portal_app/pages/meldenVertragswahl.dart';
import 'package:customer_portal_app/pages/news.dart';
import 'package:customer_portal_app/pages/settings/change_password.dart';
import 'package:customer_portal_app/pages/vertraege.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:customer_portal_app/pages/verzeichnis.dart';
import 'package:customer_portal_app/pages/wertgegenstand.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/service/session.dart';
import 'package:customer_portal_app/service/verzeichnis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pages {
  Pages(this.portal);

  final PortalService portal;

  Widget get home => HomePage(
        reloadData: () async => await portal.reload(),
        newsPage: (onRefresh, bottomNavigationBar) => news(onRefresh, bottomNavigationBar),
        vertraegePage: (onRefresh, bottomNavigationBar) =>
            vertraege(onRefresh, bottomNavigationBar),
        meldenPage: (onRefresh, bottomNavigationBar) =>
            meldenVertragswahl(onRefresh, bottomNavigationBar),
        bestandVerzeichnisPage: (onRefresh, bottomNavigationBar) =>
            verzeichnis(onRefresh, bottomNavigationBar),
        kontaktPage: (onRefresh, bottomNavigationBar) => kontakt(onRefresh, bottomNavigationBar),
      );

  Widget news(Future<void> Function() onRefresh, Widget bottomNavigationBar) => NewsPage(
        key: UniqueKey(),
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
        logout: (context) async {
          await Session.logout();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            ),
          );
        },
        changePW: (context) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangePasswordPage(
              portal: portal,
            ),
          ),
        ),
      );

  Widget vertraege(Future<void> Function() onRefresh, Widget bottomNavigationBar) => VertraegePage(
        portal.vertraege,
        key: UniqueKey(),
        viewVertrag: (context, vertrag) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => this.vertrag(vertrag)),
        ),
        erfasseFremdvertrag: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFremdvertragPage(portal: portal),
            ),
          );
        },
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      );

  Widget meldenVertragswahl(Future<void> Function() onRefresh, Widget bottomNavigationBar) =>
      MeldenVertragwahlPage(
        portal,
        key: UniqueKey(),
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      );

  Widget verzeichnis(Future<void> Function() onRefresh, Widget bottomNavigationBar) {
    var vz = VerzeichnisProvider(portal);
    vz.reload();
    return ChangeNotifierProvider.value(
      value: vz,
      child: VerzeichnisPage(
        key: UniqueKey(),
        viewWertgegenstand: (context, wertgegenstand) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WertgegenstandPage(
                wertgegenstand,
                saveWertgegenstand: (context, wertgegenstand) {
                  vz.update(wertgegenstand);
                  Navigator.pop(context);
                },
                deleteWertgegenstand: (context, wertgegenstand) {
                  vz.delete(wertgegenstand);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        erfasseWertgegenstand: (context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WertgegenstandPage(
                Wertgegenstand.empty(),
                saveWertgegenstand: (context, wertgegenstand) {
                  vz.update(wertgegenstand);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      ),
    );
  }

  Widget kontakt(Future<void> Function() onRefresh, Widget bottomNavigationBar) => ContactPage(
        key: UniqueKey(),
        portal: portal,
        bottomNavigationBar: bottomNavigationBar,
        onRefresh: onRefresh,
      );

  Widget vertrag(Vertrag vertrag) => VertragPage(
        viewDocument: (context, dokument) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilePage(portal, dokument.titel, dokument.endpoint),
            ),
          );
        },
        viewMeldeDialog: (context, vertragID, template) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeldenPage(
                portal: portal,
                vertragID: vertragID,
                template: template,
              ),
            ),
          );
        },
        vertrag: vertrag,
      );
}
