#!/bin/bash

# Script pour corriger automatiquement le bug du plugin pdf_render
# À exécuter après chaque 'flutter pub get'

PDF_RENDER_PATH="$HOME/.pub-cache/hosted/pub.dev/pdf_render-1.4.12/android/src/main/kotlin/jp/espresso3389/pdf_render/PdfRenderPlugin.kt"

if [ -f "$PDF_RENDER_PATH" ]; then
    # Vérifier si la ligne problématique existe
    if grep -q "import io.flutter.plugin.common.PluginRegistry.Registrar" "$PDF_RENDER_PATH"; then
        # Supprimer la ligne problématique
        sed -i '' '/import io.flutter.plugin.common.PluginRegistry.Registrar/d' "$PDF_RENDER_PATH"
        echo "pdf_render corrigé : ligne Registrar supprimée"
    else
        echo "pdf_render déjà corrigé"
    fi
else
    echo "Fichier pdf_render non trouvé à : $PDF_RENDER_PATH"
    echo "   Le plugin n'a peut-être pas encore été téléchargé. Exécutez 'flutter pub get' d'abord."
fi
