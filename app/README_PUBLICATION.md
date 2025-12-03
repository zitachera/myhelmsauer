# 🚀 Guide Rapide - Publication Play Store

## ⚡ Commandes Essentielles

### 1. Mettre à jour la version
Éditez `pubspec.yaml` :
```yaml
version: 1.15.0+33  # Incrémentez le +33
```

### 2. Générer l'AAB signé
```bash
cd /Users/imac/Documents/GitHub/myhelmsauer/app
flutter build appbundle --release
```

### 3. Fichier généré
```
build/app/outputs/bundle/release/app-release.aab
```

### 4. Publier sur Play Console
1. Allez sur [Google Play Console](https://play.google.com/console)
2. Créez une nouvelle version
3. Téléversez `app-release.aab`
4. Remplissez les notes de version
5. Mettez en production

---

📖 **Guide complet** : Voir `PLAYSTORE_PUBLICATION.md` pour tous les détails.
