import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactPage extends StatelessWidget {
  ContactPage({
    Key key,
  }) : super(key: key);

  static const String _phone = "123456789";
  static const String _mail = "info@helmsauer-gruppe.de";
  static const String _web = "helmsauer-gruppe.de";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
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
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    this.caption,
    this.child,
    this.onPressed,
  }) : super(key: key);

  _Button.url({
    Key key,
    this.caption,
    String value,
    String url,
  })  : child = Text(
          value,
          textScaleFactor: 1.3,
        ),
        onPressed = (() => UrlLauncher.launch(url)),
        super(key: key);

  final String caption;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
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
