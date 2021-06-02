import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactPage extends StatelessWidget {
  ContactPage({
    Key? key,
  }) : super(key: key);

  static const String _phone = "0911/9292-03";
  static const String _mail = "info@helmsauer-gruppe.de";
  static const String _web = "www.helmsauer-gruppe.de";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            "Kontakt",
            textScaleFactor: 2,
          ),
        ),
        _Button.url(
          caption: "Telefon",
          value: _phone,
          url: 'tel://$_phone',
        ),
        _Button.url(
          caption: "Mail",
          value: _mail,
          url: 'mailto://$_mail',
        ),
        _Button.url(
          caption: "Website",
          value: _web,
          url: 'http://$_web',
        ),
        SizedBox(height: 150),
        Row(
          children: <Widget>[
            Expanded(
                child: _Link("Datenschutz",
                    "https://www.helmsauer-gruppe.de/ueber-helmsauer/datenschutz/")),
            Expanded(
                child: _Link("Impressum",
                    "https://www.helmsauer-gruppe.de/ueber-helmsauer/impressum/")),
          ],
        )
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.caption,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  _Button.url({
    Key? key,
    required this.caption,
    required String value,
    String? url,
  })  : child = Text(
          value,
          textScaleFactor: 1.3,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: helmsauerBlue,
          ),
        ),
        onPressed = (() => UrlLauncher.launch(url!)),
        super(key: key);

  final String caption;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed as void Function()?,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            caption + ":",
            textScaleFactor: 1.3,
          ),
          child,
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
        textScaleFactor: 1.3,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: helmsauerBlue,
        ),
      ),
    );
  }
}
