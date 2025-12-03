# Guide de Publication sur Google Play Store

Ce guide vous explique comment publier l'application **myHelmsauer** sur le Google Play Store.

## 📋 Prérequis

1. **Compte développeur Google Play** (frais unique de 25$)
2. **Fichier de clé de signature** (`my-release-key.jks`) - déjà présent dans le projet
3. **Fichier `key.properties`** configuré dans `app/android/`

## 🔐 Configuration de la Signature

### 1. Créer le fichier `key.properties`

Créez le fichier `/Users/imac/Documents/GitHub/myhelmsauer/app/android/key.properties` avec le contenu suivant :

```properties
storePassword=votre_mot_de_passe_keystore
keyPassword=votre_mot_de_passe_key
keyAlias=votre_alias
storeFile=/Users/imac/Documents/GitHub/myhelmsauer/my-release-key.jks
```

⚠️ **Important** : Ne commitez JAMAIS ce fichier dans Git ! Il est déjà dans `.gitignore`.

### 2. Configurer le build.gradle pour la signature

✅ **Déjà configuré !** Le fichier `app/android/app/build.gradle` est déjà configuré pour utiliser la signature automatiquement lors des builds release.

La configuration utilise le fichier `key.properties` que vous devez créer à l'étape 1.

## 📦 Étapes de Publication

### Étape 1 : Mettre à jour la Version

Avant chaque publication, mettez à jour la version dans `app/pubspec.yaml` :

```yaml
version: 1.15.0+32
```

- **1.15.0** = versionName (visible pour les utilisateurs)
- **32** = versionCode (doit être incrémenté à chaque publication)

⚠️ **Important** : Le `versionCode` doit être supérieur à la version précédente sur le Play Store.

### Étape 2 : Générer le fichier AAB (Android App Bundle)

Le Play Store nécessite un fichier **AAB** (Android App Bundle), pas un APK.

```bash
cd /Users/imac/Documents/GitHub/myhelmsauer/app
flutter build appbundle --release
```

Le fichier sera généré dans :
```
build/app/outputs/bundle/release/app-release.aab
```

### Étape 3 : Vérifier le fichier AAB

Vérifiez que le fichier a été créé :

```bash
ls -lh build/app/outputs/bundle/release/app-release.aab
```

### Étape 4 : Publier sur Google Play Console

1. **Connectez-vous** à [Google Play Console](https://play.google.com/console)

2. **Sélectionnez votre application** (myHelmsauer)

3. **Allez dans "Production"** (ou "Internal testing" / "Closed testing" pour tester d'abord)

4. **Cliquez sur "Créer une nouvelle version"**

5. **Téléversez le fichier AAB** :
   - Fichier : `app/build/app/outputs/bundle/release/app-release.aab`
   - Taille : ~60-70 MB

6. **Remplissez les notes de version** :
   - Titre : "Version 1.15.0"
   - Notes : Description des nouveautés et corrections

7. **Vérifiez les informations** :
   - Version du code : doit correspondre au `versionCode` dans `pubspec.yaml`
   - Version du nom : doit correspondre au `versionName` dans `pubspec.yaml`

8. **Sauvegardez** et **Examinez la version**

9. **Une fois l'examen terminé**, cliquez sur **"Mettre en production"**

## 🔍 Vérifications Avant Publication

### ✅ Checklist

- [ ] Version incrémentée dans `pubspec.yaml`
- [ ] Fichier `key.properties` configuré correctement
- [ ] Build AAB généré avec succès
- [ ] Application testée sur plusieurs appareils
- [ ] Toutes les fonctionnalités testées
- [ ] API de production configurée (`schadenmeldung.helmsauer-gruppe.de`)
- [ ] Permissions Android vérifiées
- [ ] Politique de confidentialité à jour (si nécessaire)
- [ ] Captures d'écran et description à jour sur Play Console

## 🚀 Commandes Rapides

### Générer l'AAB pour production
```bash
cd /Users/imac/Documents/GitHub/myhelmsauer/app
flutter build appbundle --release
```

### Vérifier la configuration de signature
```bash
cd /Users/imac/Documents/GitHub/myhelmsauer/app/android
cat key.properties  # Vérifier que le fichier existe et est correct
```

### Nettoyer avant un nouveau build
```bash
cd /Users/imac/Documents/GitHub/myhelmsauer/app
flutter clean
flutter pub get
flutter build appbundle --release
```

## 📱 Configuration de l'API en Production

L'application est configurée pour utiliser automatiquement l'API de production lors des builds release :

- **Production** : `https://schadenmeldung.helmsauer-gruppe.de/api/v1/`
- **Test** : `https://testschadenmeldung.helmsauer-gruppe.de/api/v1/`

La détection se fait via `dart.vm.product` qui est activé automatiquement lors des builds `--release`.

## ⚠️ Notes Importantes

1. **Signature** : Utilisez TOUJOURS la même clé de signature pour toutes les mises à jour. Sinon, les utilisateurs ne pourront pas mettre à jour l'application.

2. **Version Code** : Doit être unique et croissant. Google Play rejette les versions avec un `versionCode` inférieur ou égal à la version précédente.

3. **Version Name** : Peut être n'importe quelle chaîne (ex: "1.15.0", "2.0-beta"), mais doit être cohérente.

4. **Temps de traitement** : Google Play peut prendre plusieurs heures à plusieurs jours pour examiner et publier une nouvelle version.

5. **Tests** : Utilisez d'abord "Internal testing" ou "Closed testing" pour tester avant de publier en production.

## 🔗 Liens Utiles

- [Google Play Console](https://play.google.com/console)
- [Documentation Flutter - Build and Release](https://docs.flutter.dev/deployment/android)
- [Guide Android App Bundle](https://developer.android.com/guide/app-bundle)

## 📞 Support

En cas de problème :
1. Vérifiez les logs : `flutter build appbundle --release -v`
2. Consultez la documentation Flutter
3. Vérifiez les erreurs dans Google Play Console

---

**Dernière mise à jour** : Décembre 2024
**Version actuelle** : 1.15.0+32
