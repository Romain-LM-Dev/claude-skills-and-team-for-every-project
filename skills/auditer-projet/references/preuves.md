# Preuves, chiffrage et rapport

## Niveaux de preuve
| Niveau | Ce que c'est | Exemple | Suffit pour le classement ? |
|---|---|---|---|
| M | mesuré ici, avant et après, sur une copie | médiane de 5 exécutions : 840 ms → 35 ms, mêmes données | oui |
| R | reproduit : test ou commande qui échoue aujourd'hui | test qui lève `ZeroDivisionError` sur une liste vide | oui |
| S | constat statique : fichier:ligne, métrique d'un outil | boucle imbriquée en `stats.py:12` ; 0 appel trouvé par l'outil de code mort | seulement s'il établit le gain seul |
| E | source externe datée | avis de sécurité visant la version installée, doc officielle d'une option | seulement s'il établit le gain seul |
| H | hypothèse, raisonnement sans observation | « sera sans doute plus rapide en X » | non : « Pistes à vérifier » |

Une affirmation sans niveau est une hypothèse. Le niveau se note dans chaque ligne du rapport.

## Mesurer honnêtement
- Même machine, mêmes données, même configuration avant et après ; données représentatives (taille réelle, pas un
  jouet) ; préchauffage puis au moins 5 répétitions, médiane et écart.
- Une différence inférieure au bruit (écart entre répétitions) n'est pas un gain.
- Mesure l'effet sur l'objectif (temps de réponse ressenti, coût mensuel, durée de CI), pas seulement un indicateur
  intermédiaire.
- Copie jetable : `git worktree add ../<projet>-audit HEAD`, ou dossier temporaire ; supprimée à la fin.
- Mesure impossible ici (pas de shell, pas de données) : niveau H, avec la commande exacte qui trancherait.

## Chiffrer gain et coût
- Gain : unité du projet, avant → après, conditions, niveau de preuve. Sur un horizon donné si c'est cumulatif
  (minutes de CI par mois, € par mois).
- Coût : effort (heures ou jours), fichiers touchés, risque (contrat public, données, sécurité), réversibilité.
- Classement : gain/coût décroissant ; à égalité, le plus réversible d'abord. « Gains rapides » : moins d'une heure,
  niveau M ou R.
- Effets de bord : ce que le changement dégrade (lisibilité, mémoire, dépendance de plus) se chiffre aussi.

## Modèle de rapport
```markdown
# Audit de <projet> (<AAAA-MM-JJ>, profondeur <rapide|standard|profonde>)

## Objectifs et contraintes
## État de base
| Commande | Résultat | Durée |
## Recommandations (classées par gain/coût)
| # | Constat (fichier:ligne) | Changement | Gain (avant → après) | Coût | Preuve | Vérifier avec |
## Gains rapides
## Changements de fond
<décision : migrer, garder, ou piste ; prototype, mesures, coût total, chemin progressif ; ou « aucun déclencheur »>
## Ce qui va bien et ne doit pas bouger
## Pistes à vérifier (H)
| Piste | Pourquoi on y croit | Mesure qui trancherait |
## Sources (datées)
## Savoir proposé
## Évolution de la skill proposée
```
