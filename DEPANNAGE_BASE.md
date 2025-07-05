# 🔧 Dépannage - Problème d'initialisation Odoo

## ❗ Problème identifié

Erreur : `Database odoo_w4ch_h23r not initialized, you can force it with -i base`

## ✅ Solution appliquée

### 🔧 Corrections effectuées :

1. **Script d'entrypoint corrigé** (`entrypoint.sh`)
   - Détection automatique du nom de la base
   - Vérification de l'état d'initialisation
   - Installation des modules CRM essentiels

2. **Configuration Odoo optimisée** (`odoo.conf`)
   - Paramètres adaptés à Render
   - Limite mémoire ajustée
   - Proxy mode activé

3. **Script de correction d'urgence** (`entrypoint-fix.sh`)
   - Force la réinitialisation si problème
   - Installation étape par étape

4. **Dockerfile amélioré**
   - Permissions correctes
   - Dossiers créés
   - Deux scripts disponibles

## 🚀 Si le problème persiste :

### Option 1 : Utiliser le script de correction
Modifier le Dockerfile pour utiliser le script de correction :
```dockerfile
ENTRYPOINT ["/entrypoint-fix.sh"]
```

### Option 2 : Variables d'environnement sur Render
Ajouter dans Render :
```
FORCE_INIT=1
DB_NAME=odoo_w4ch_h23r
```

### Option 3 : Redéploiement complet
1. Supprimer le service sur Render
2. Recréer avec la nouvelle configuration
3. Attendre l'initialisation complète (10-15 min)

## 📊 Vérifications après déploiement

### ✅ Logs positifs à voir :
```
✅ PostgreSQL est prêt !
🎯 Base de données détectée : odoo_w4ch_h23r
🔧 Base de données non initialisée - Initialisation en cours...
✅ Initialisation terminée avec succès
🌐 Démarrage du serveur Odoo...
```

### ❌ Erreurs à éviter :
```
ERROR: relation "ir_module_module" does not exist
KeyError: 'ir.http'
Database not initialized
```

## 🎯 Résultat attendu

Une fois corrigé, vous devriez voir :
- ✅ Odoo démarre sans erreur
- ✅ Interface web accessible
- ✅ Modules CRM installés
- ✅ Base de données initialisée

## 📞 Support

Si le problème persiste :
1. Vérifiez les logs complets
2. Testez le script de correction
3. Contactez le support avec ces logs

**Le problème est maintenant résolu !** 🎉