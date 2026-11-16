---
name: auditer-projet
description: Audite un projet et classe les améliorations par gain prouvé (mesure, test, source datée), du code aux outils et à l'architecture, jusqu'au changement de langage s'il est mesuré meilleur.
---
# Auditer un projet

But : la liste classée des changements qui rendent ce projet réellement meilleur pour les objectifs de son
propriétaire, chacun avec sa preuve et la commande qui la vérifie. « Ne rien changer » est un résultat valide ; un
changement sans preuve n'est qu'une piste.

L'audit ne modifie pas le projet : mesures et prototypes se font dans une copie jetable (`git worktree add`, dossier
temporaire). Seul le rapport est écrit, après accord de l'utilisateur.

## 0. Cadrer (avant de lire le code)
- Objectifs, c'est-à-dire ce que « mieux » veut dire ici : vitesse, coût, fiabilité, sécurité, maintenance, prise en
  main. Sans réponse, tous, pondérés par ce que montrent les mesures. Contraintes : langage ou outil imposé, délai,
  budget, compétences de l'équipe.
- Profondeur : `rapide` (lecture et outils déjà présents), `standard` (défaut ; plus mesures avant/après sur les
  points chauds), `profonde` (plus prototypes et bancs d'essai). Annonce le coût des mesures longues (installation,
  banc de plusieurs minutes, sous-agents) et attends l'accord.
- Savoir, du plus général au plus particulier (le plus particulier l'emporte) :
  1. `references/` de cette skill : la méthode ;
  2. `~/.claude/audit-savoir.md` : leçons et préférences de l'utilisateur, tous projets (s'il existe) ;
  3. `docs/audit/savoir.md`, CLAUDE.md, ADR et audits précédents (`docs/audit/`) du projet ;
  4. documents, liens et consignes donnés avec la demande.
  Une décision déjà prise dans un ADR ne se rouvre qu'avec une mesure nouvelle.
- Faits qui vieillissent (versions, prix, failles, performances d'un outil) : jamais de mémoire. Source à jour
  (documentation officielle, registre de paquets, base de failles, recherche web), datée dans le rapport.

## 1. Inventaire et état de base (outils d'abord, lecture ensuite)
- Pile, taille (lignes par langage), dépendances et leur âge, commandes de build, de test, de lint et de lancement
  (manifestes, scripts, CI).
- Lance une fois build, tests, lint et audit des dépendances : résultat, durée, couverture si disponible. C'est l'état
  de base contre lequel chaque gain se mesure. Une commande qui ne marche pas est déjà un constat.
- Points chauds : fichiers les plus modifiés (`git log --since=1.year --name-only --format=`), les plus gros, les plus
  complexes, ceux que touchent les correctifs (messages « fix »). L'analyse commence par eux.
- Dépôt gros, en Claude Code : délègue l'inventaire à des agents `Explore` en parallèle, un par dimension, au palier
  économe, avec un brief en cinq rubriques (skill `regles-equipe` si disponible).

## 2. Analyser
Parcours les dimensions de `references/dimensions.md` en commençant par les points chauds. Pour chaque constat :
fichier et ligne, effet concret sur un objectif, changement proposé, preuve qu'on peut obtenir. Pas de constat de
goût (style, nommage) sans effet mesurable.

## 3. Prouver
Niveaux et règles dans `references/preuves.md`. En bref :
- M mesuré ici, avant et après, sur la copie ; R reproduit (test ou commande qui échoue) ; S constat statique
  (fichier:ligne, métrique d'outil) ; E source externe datée ; H hypothèse.
- Le classement ne retient que M et R, et S ou E quand ils établissent le gain à eux seuls (faille connue de la
  version utilisée, code mort prouvé par l'outil). H va dans « Pistes à vérifier », avec la mesure qui trancherait.
- Chaque gain est chiffré dans l'unité du projet (ms au 95e centile, Mo, € par mois, minutes de CI, défauts, lignes) :
  avant, après, conditions de mesure. Une mesure qui ne montre rien est un résultat : la proposition tombe.

## 4. Changements de fond (langage, framework, outil, hébergement)
Seulement si une limite mesurée de la pile actuelle bloque un objectif, après avoir épuisé les correctifs dans la
pile. Protocole dans `references/migration.md` : prototype sur une tranche représentative, mêmes entrées et même
mesure, coût total de la migration, chemin progressif. Sans prototype mesuré, c'est une piste, jamais une
recommandation. « Garder la pile » est souvent la bonne réponse : dis-le avec ses chiffres.

## 5. Contre-vérifier
Les trois premières recommandations et tout changement de fond : relecture indépendante (agent `qa-reviewer` ou
autre modèle, même consigne) ou nouvelle mesure par une autre méthode. Un désaccord se tranche par une commande.

## 6. Rendre
- Rapport selon le modèle de `references/preuves.md`, dans `docs/audit/<AAAA-MM-JJ>-audit.md` après accord (dans la
  réponse s'il n'y a pas de système de fichiers) : objectifs, état de base, recommandations classées par gain/coût,
  changements de fond, ce qui va bien et ne doit pas bouger, pistes à vérifier, sources datées.
- Dix recommandations au plus dans le classement ; le reste en annexe.
- Savoir : propose les leçons à garder, une ligne datée chacune (« constat → changement → gain mesuré, projet »),
  dans `docs/audit/savoir.md` (ce projet) ou `~/.claude/audit-savoir.md` (tous projets), après accord. Une
  recommandation d'un audit précédent qui a été appliquée : mesure son gain réel et note-le. Une leçon confirmée
  pèse plus ; une leçon démentie est retirée.
- Évolution de la skill : une étape fausse, inutile ou dépassée (outil disparu, meilleure méthode, modèle capable
  d'aller plus loin) donne une proposition de modification de `references/` ou de ce fichier, avec sa preuve.

## Modèles
Aucun nom de modèle ici, seulement des paliers (`regles-equipe`) : inventaire et relevés au palier économe, analyse
et arbitrage au modèle de la session, contre-vérification par un autre modèle. Un modèle plus fort peut creuser plus
loin, jamais abaisser la barre de preuve. Quand un modèle sort, `choisir-modeles` mesure cette skill avec l'éval
`audit-preuve` du plugin et garde le réglage le moins cher qui la réussit.

## Langue
Langue : réponds (comptes rendus, questions) dans la langue de la demande, qui est celle de l'utilisateur, sauf instruction contraire ; les fichiers produits suivent la langue fixée par le projet.
