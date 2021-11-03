import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        _Button(
          caption: "Telefon",
          icon: SvgPicture.asset(
            "images/menu/telefon.svg",
            color: helmsauerBlau,
          ),
          label: _phone,
          url: 'tel://$_phone',
        ),
        _Button(
          caption: "Mail",
          icon: SvgPicture.asset(
            "images/menu/email.svg",
            color: helmsauerBlau,
          ),
          label: _mail,
          url: 'mailto://$_mail',
        ),
        _Button(
          caption: "Website",
          icon: SvgPicture.asset(
            "images/menu/webadresse.svg",
            color: helmsauerBlau,
          ),
          label: _web,
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
    required this.url,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String caption;
  final String url;
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1 ?? TextStyle();
    return MaterialButton(
      onPressed: () => UrlLauncher.launch(url),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  caption + ":",
                  style: textStyle,
                ),
                Text(
                  label,
                  style: textStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
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
          color: helmsauerBlau,
        ),
      ),
    );
  }
}
