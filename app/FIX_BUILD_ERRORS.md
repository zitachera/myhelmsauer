Correction des Erreurs de Build

SOLUTION RAPIDE (3 commandes)

git pull origin develop
cd app
./fix_pdf_render.sh
flutter clean && flutter pub get && ./fix_pdf_render.sh && flutter build appbundle --release

C'est tout !

CORRECTION MANUELLE (si le script ne fonctionne pas)

1. Ouvrir le fichier :
   ~/.pub-cache/hosted/pub.dev/pdf_render-1.4.12/android/src/main/kotlin/jp/espresso3389/pdf_render/PdfRenderPlugin.kt

2. Supprimer la ligne 21 :
   import io.flutter.plugin.common.PluginRegistry.Registrar

3. Sauvegarder et reconstruire

VERIFICATIONS

- Android SDK 36 installé dans Android Studio
- Kotlin 2.1.0 configuré (déjà fait dans le code)
- Script fix_pdf_render.sh exécuté après chaque flutter pub get

NOTE IMPORTANTE

Exécutez ./fix_pdf_render.sh après chaque flutter pub get car le bug se réinstalle.
