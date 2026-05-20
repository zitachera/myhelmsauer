import 'package:flutter/material.dart';
import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/svgicon.dart';

typedef PageFunc = Widget Function(
  Future<void> Function() onRefresh,
  Widget bottomNavigationBar,
);

class HomePage extends StatefulWidget {
  const HomePage({
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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Future<void> _reload() async {
    await widget.reloadData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: helmsauerBlau,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/home.svg"),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/vertrag.svg"),
          label: 'Vertrag',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon("images/menu/schaden.svg", color: Colors.red),
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
      default:
        return widget.newsPage(_reload, bottomNavigationBar);
    }
  }
}

/// ===============================================================
///  HOME INTERIOR PREMIUM CONTENT (pour News/Home tab si besoin) passwort ändern

/// ===============================================================

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SECTION SICHERHEIT
          Row(
            children: [
              Container(
                width: 5,
                height: 22,
                decoration: BoxDecoration(
                  color: helmsauerBlau,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Sicherheit",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: helmsauerBlau,
                    ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _SecurityCard(
                  icon: Icons.lock_outline,
                  title: "Passwort ändern",
                  subtitle: "Aktualisieren Sie Ihr Passwort",
                  color: helmsauerBlau,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SecurityCard(
                  icon: Icons.logout,
                  title: "Log out",
                  subtitle: "Sicher abmelden",
                  color: Colors.red.shade400,
                  isDanger: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          /// CYBER FEATURE CARD
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "images/cybercrime.jpg",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.75),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    bottom: 22,
                    right: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Cyberkriminalität",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "So schützen Sie Ihr Unternehmen vor digitalen Risiken.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// FAQ CARD
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: helmsauerBlau.withOpacity(0.08),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: helmsauerBlau.withOpacity(0.1),
                  child: const Icon(
                    Icons.article_outlined,
                    color: helmsauerBlau,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Auf der Startseite finden Sie regelmäßig neue Artikel "
                    "zu Versicherungsthemen und aktuellen Entwicklungen.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isDanger;

  const _SecurityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isDanger ? Colors.red.shade400 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
