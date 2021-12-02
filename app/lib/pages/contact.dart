import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/stretchScroll.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactPage extends StatelessWidget {
  ContactPage({
    Key? key,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.portal,
  }) : super(key: key);

  final Widget? bottomNavigationBar;

  final Future<void> Function()? onRefresh;

  final Portal portal;

  static const String _phone = "0911/9292-03";
  static const String _mail = "info@helmsauer-gruppe.de";
  static const String _web = "www.helmsauer-gruppe.de";

  @override
  Widget build(BuildContext context) {
    final content = StretchScroll(
      onRefresh: onRefresh,
      children: <Widget>[
        Column(children: <Widget>[
          _Button.url(
            caption: "Telefon",
            icon: SvgPicture.asset(
              "images/menu/telefon.svg",
              color: helmsauerBlau,
            ),
            label: _phone,
            url: 'tel://$_phone',
          ),
          _Button.url(
            caption: "Mail",
            icon: SvgPicture.asset(
              "images/menu/email.svg",
              color: helmsauerBlau,
            ),
            label: _mail,
            url: 'mailto://$_mail',
          ),
          _Button.url(
            caption: "Website",
            icon: SvgPicture.asset(
              "images/menu/webadresse.svg",
              color: helmsauerBlau,
            ),
            label: _web,
            url: 'http://$_web',
          ),
          _Button(
            child: Text("Nachricht schreiben"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagePage(portal: portal),
              ),
            ),
            icon: SvgPicture.asset(
              "images/menu/chat.svg",
              color: helmsauerBlau,
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: _Link("Datenschutz",
                      "https://www.helmsauer-gruppe.de/ueber-helmsauer/datenschutz/")),
              Expanded(
                  child: _Link("Impressum",
                      "https://www.helmsauer-gruppe.de/ueber-helmsauer/impressum/")),
            ],
          ),
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontakt"),
      ),
      body: content,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final Widget icon;

  _Button.url({
    Key? key,
    required String url,
    required String caption,
    required String label,
    required this.icon,
  })  : onPressed = (() => UrlLauncher.launch(url)),
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(caption + ":"),
            Text(
              label,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: FittedBox(
                child: icon,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link(
    this.text,
    this.url, {
    Key? key,
  }) : super(key: key);

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => UrlLauncher.launch(url),
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
