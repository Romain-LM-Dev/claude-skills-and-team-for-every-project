# Dimensions à parcourir

Chaque ligne donne la question, les signaux, et comment mesurer. Les outils cités sont des exemples à vérifier au
jour de l'audit (versions, existence) : préfère ceux que le projet utilise déjà.

| Dimension | Question | Signaux | Mesurer avec |
|---|---|---|---|
| Exactitude | Le code fait-il ce qu'il promet, y compris aux bords ? | cas limites non testés, erreurs avalées, divisions, `None`, fuseaux, arrondis monétaires | test qui échoue (R), cas limite exécuté |
| Sécurité | Une entrée non fiable peut-elle nuire ? | requêtes construites par concaténation, secrets dans le dépôt, désérialisation, dépendances vulnérables, droits trop larges | audit de dépendances (npm audit, pip-audit, cargo audit, dotnet list package --vulnerable), recherche de secrets, avis datés (E) |
| Performance | Où part le temps ou la mémoire sur les parcours réels ? | boucles imbriquées sur des collections, requêtes N+1, appels réseau en série, absence de cache sur un calcul pur, gros objets copiés | profileur du langage, banc d'essai avant/après (M), journal des requêtes |
| Fiabilité | Que se passe-t-il quand ça casse ? | pas de délai sur les appels externes, pas de reprise, état partagé sans verrou, écriture non atomique | injection de panne, test de concurrence, relance de la CI pour les tests instables |
| Maintenabilité | Combien coûte un changement ici ? | points chauds à la fois gros, complexes et souvent modifiés ; duplication ; couplage entre couches | complexité et duplication par outil (S), historique git : fichiers modifiés ensemble |
| Tests | Les tests protègent-ils ce qui compte ? | parcours critiques sans test, tests lents ou instables, assertions faibles | couverture des points chauds, durée et taux d'échec de la suite, test de mutation si disponible |
| Dépendances | Chaque dépendance vaut-elle son coût ? | paquet abandonné, versions très en retard, doublons, dépendance lourde pour une fonction | registre (date de dernière version), taille installée, arbre des dépendances |
| Architecture | La structure sert-elle les changements fréquents ? | une modification typique touche beaucoup de fichiers ; cycles entre modules ; logique métier dans l'interface | historique git (fichiers co-modifiés), graphe d'import |
| Outillage et CI | Le cycle modifier-vérifier est-il court et sûr ? | pas de lint ni de formateur, CI longue, étapes manuelles, build non reproductible | durée de la CI et du build local, étapes manuelles comptées |
| Coût d'exploitation | Que coûte le projet à faire tourner ? | ressources surdimensionnées, appels payants répétés, stockage sans purge | facture ou grille tarifaire datée (E), métriques d'usage |
| Accessibilité | Tout le monde peut-il s'en servir ? (interfaces) | contrastes, navigation clavier, libellés, textes alternatifs | outil d'audit d'accessibilité, parcours au clavier |
| Documentation | Un nouvel arrivant lance-t-il le projet seul ? | README faux, commandes qui ne marchent pas, décisions non écrites | suivre le README depuis zéro et noter les écarts |

## Pièges
- Ne propose pas de réécrire ce qui marche et change peu : le coût du changement doit être payé par un gain.
- Un point chaud se lit en premier, un fichier stable en dernier.
- Plusieurs constats de même cause font une seule recommandation.
- Le projet a ses propres points de relecture (CLAUDE.md) : vérifie-les en plus.
