/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/stretchScroll.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/pages/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactPage extends StatelessWidget {
  const ContactPage({
    super.key,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.portal,
  });

  final Widget? bottomNavigationBar;

  final Future<void> Function()? onRefresh;

  final PortalService portal;

  static const String _phone = "0911/9292-03";
  static const String _mail = "info@helmsauer-gruppe.de";
  static const String _web = "www.helmsauer-gruppe.de";

  @override
  Widget build(BuildContext context) {
    const filter = ColorFilter.mode(helmsauerBlau, BlendMode.srcIn);
    final content = StretchScroll(
      onRefresh: onRefresh,
      children: <Widget>[
        Column(children: <Widget>[
          _Button.url(
            caption: "Telefon",
            icon: SvgPicture.asset(
              "images/menu/telefon.svg",
              colorFilter: filter,
            ),
            label: _phone,
            url: 'tel://$_phone',
          ),
          _Button.url(
            caption: "Mail",
            icon: SvgPicture.asset(
              "images/menu/email.svg",
              colorFilter: filter,
            ),
            label: _mail,
            url: 'mailto://$_mail',
          ),
          _Button.url(
            caption: "Website",
            icon: SvgPicture.asset(
              "images/menu/webadresse.svg",
              colorFilter: filter,
            ),
            label: _web,
            url: 'https://$_web',
          ),
          _Button(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagePage(portal: portal),
              ),
            ),
            icon: SvgPicture.asset(
              "images/menu/chat.svg",
              colorFilter: filter,
            ),
            child: Text("Nachricht schreiben"),
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
    required this.onPressed,
    required this.child,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget icon;

  _Button.url({
    required String url,
    required String caption,
    required String label,
    required this.icon,
  })  : onPressed = (() => UrlLauncher.launchUrl(Uri.parse(url))),
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("$caption:"),
            Text(
              label,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        );

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
                fit: BoxFit.fitWidth,
                child: icon,
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
  const _Link(this.text, this.url);

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => UrlLauncher.launchUrl(Uri.parse(url)),
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
}*/


/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/stretchScroll.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/pages/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    super.key,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.portal,
  });

  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;
  final PortalService portal;

  static const String _phone = "0911/9292-03";
  static const String _mail = "info@helmsauer-gruppe.de";
  static const String _web = "www.helmsauer-gruppe.de";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kontakt"),
        centerTitle: true,
      ),
      body: StretchScroll(
        onRefresh: onRefresh,
        children: [
          const SizedBox(height: 20),

          _ContactCard(
            iconPath: "images/menu/telefon.svg",
            title: "Telefon",
            subtitle: _phone,
            onTap: () => launchUrl(Uri.parse("tel:$_phone")),
          ),

          _ContactCard(
            iconPath: "images/menu/email.svg",
            title: "E-Mail",
            subtitle: _mail,
            onTap: () => launchUrl(Uri.parse("mailto:$_mail")),
          ),

          _ContactCard(
            iconPath: "images/menu/webadresse.svg",
            title: "Website",
            subtitle: _web,
            onTap: () => launchUrl(Uri.parse("https://$_web")),
          ),

          _ContactCard(
            iconPath: "images/menu/chat.svg",
            title: "Nachricht schreiben",
            subtitle: "Direkt Kontakt aufnehmen",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MessagePage(portal: portal),
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _FooterLink(
                    text: "Datenschutz",
                    url:
                        "https://www.helmsauer-gruppe.de/ueber-helmsauer/datenschutz/",
                  ),
                ),
                Expanded(
                  child: _FooterLink(
                    text: "Impressum",
                    url:
                        "https://www.helmsauer-gruppe.de/ueber-helmsauer/impressum/",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/* =======================
   =   WIDGET CARTE      =
   ======================= */

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: helmsauerBlau.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 26,
                      height: 26,
                      colorFilter: const ColorFilter.mode(
                        helmsauerBlau,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* =======================
   =   LIENS DU BAS       =
   ======================= */

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.text, required this.url});

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => launchUrl(Uri.parse(url)),
      child: Text(
        text,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}*/


import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/stretchScroll.dart';
import 'package:customer_portal_app/pages/message.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    super.key,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.portal,
  });

  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;
  final PortalService portal;

  static const String _phone = "0911/9292-03";
  static const String _mail = "info@helmsauer-gruppe.de";
  static const String _web = "www.helmsauer-gruppe.de";

  @override
  Widget build(BuildContext context) {
    const filter = ColorFilter.mode(helmsauerBlau, BlendMode.srcIn);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: helmsauerBlau,
        centerTitle: true,
        title: const Text(
          "Kontakt",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: StretchScroll(
        onRefresh: onRefresh,
        children: [
          const SizedBox(height: 12),

          _ContactCard(
            icon: SvgPicture.asset(
              "images/menu/telefon.svg",
              colorFilter: filter,
            ),
            title: "Telefon",
            subtitle: _phone,
            onTap: () => launchUrl(Uri.parse("tel:$_phone")),
          ),

          _ContactCard(
            icon: SvgPicture.asset(
              "images/menu/email.svg",
              colorFilter: filter,
            ),
            title: "E-Mail",
            subtitle: _mail,
            onTap: () => launchUrl(Uri.parse("mailto:$_mail")),
          ),

          _ContactCard(
            icon: SvgPicture.asset(
              "images/menu/webadresse.svg",
              colorFilter: filter,
            ),
            title: "Website",
            subtitle: _web,
            onTap: () => launchUrl(Uri.parse("https://$_web")),
          ),

          _ContactCard(
            icon: SvgPicture.asset(
              "images/menu/chat.svg",
              colorFilter: filter,
            ),
            title: "Nachricht",
            subtitle: "Nachricht schreiben",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MessagePage(portal: portal),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _LegalTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Datenschutz",
                  onTap: () => launchUrl(
                    Uri.parse(
                      "https://www.helmsauer-gruppe.de/ueber-helmsauer/datenschutz/",
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _LegalTile(
                  icon: Icons.info_outline,
                  title: "Impressum",
                  onTap: () => launchUrl(
                    Uri.parse(
                      "https://www.helmsauer-gruppe.de/ueber-helmsauer/impressum/",
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          onTap: onTap,
          leading: SizedBox(width: 36, height: 36, child: icon),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class _LegalTile extends StatelessWidget {
  const _LegalTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: helmsauerBlau),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.open_in_new),
      ),
    );
  }
}


