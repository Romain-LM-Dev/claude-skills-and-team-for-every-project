# Changer de langage, de framework, d'outil ou d'hébergement

Un changement de fond se recommande seulement s'il est mesuré meilleur, coût de migration compris. « Garder la pile »
est un résultat valide et fréquent : écris-le avec ses chiffres.

## Déclencheurs recevables
- Une limite mesurée bloque un objectif et résiste aux correctifs dans la pile (plafond de performance après
  correction des algorithmes et de la configuration, mémoire, temps de démarrage).
- L'écosystème ne suit plus : composant abandonné, faille sans correctif, plateforme cible non supportée (sources
  datées, niveau E).
- Un coût d'exploitation ou de développement chiffré, durable, qu'une alternative supprime.
- Une contrainte de l'équipe ou du projet (compétences, cible imposée) donnée par l'utilisateur.

Ne suffisent pas : la mode, le goût, un banc d'essai générique trouvé en ligne, « plus moderne », « plus propre ».

## Protocole
1. Énonce l'objectif bloqué et la limite actuelle, mesurée (niveau M ou R).
2. Épuise les correctifs dans la pile : profileur, algorithme, configuration, cache, extension native, parallélisme.
   Mesure après chacun. Souvent la limite disparaît ici : fin du protocole.
3. Deux candidats au plus, choisis sur sources datées (maturité, maintenance, licence, compétences de l'équipe).
4. Prototype sur une tranche représentative (le parcours qui porte la limite), dans une copie jetable, avec les mêmes
   entrées et la même mesure que l'état de base. Jamais dans le code de l'utilisateur.
5. Coût total : lignes et modules à réécrire, tests à porter, équivalents des dépendances, build, CI, déploiement,
   formation, risque de régression, durée. Chemin progressif possible (étrangleur, interface native, service à côté)
   et son coût.
6. Décision :
   - migrer si le gain mesuré sur la tranche dépasse nettement le bruit ET si le gain sur l'horizon du projet dépasse
     le coût total ; préfère alors le chemin progressif ;
   - garder sinon, en notant ce qui ferait changer la décision (seuil, événement) ;
   - piste si le prototype n'a pas pu être mesuré : jamais une recommandation.
7. Propose un ADR (contexte, options, décision, conséquences) avec les mesures, à faire valider par l'utilisateur
   avant toute migration.

## Contre-vérification
Tout changement de fond est relu par un second regard indépendant (autre agent ou autre modèle) avant d'être présenté.
Un désaccord se tranche par une nouvelle mesure.
