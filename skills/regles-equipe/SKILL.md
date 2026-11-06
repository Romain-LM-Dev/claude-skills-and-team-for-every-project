---
name: regles-equipe
description: Règles de coût et de délégation d'une équipe d'agents Claude Code. À utiliser avant de déléguer, de choisir un modèle ou de rédiger un brief de sous-agent.
---
# Règles de coût et de délégation

## Quand déléguer
Un sous-agent coûte un contexte neuf (CLAUDE.md et brief relus). Déléguer ce qui se règle en deux minutes coûte plus
que le faire directement. Il se justifie pour : une sortie volumineuse à résumer, un travail autonome ou parallèle,
une relecture à contexte neuf. Sinon, fais-le dans le fil principal.

## Priorité du projet
Un agent ou une skill du projet (`.claude/agents`, `.claude/skills`) qui couvre le domaine d'une tâche prime toujours.
Un agent du plugin (`team-for-every-project:...`) ne sert que pour un domaine que le projet ne couvre pas. Avant de
déléguer, compare les descriptions des agents du projet et du plugin.

## Choix du modèle
| Tâche | Modèle |
|---|---|
| Mécanique : recherche, renommage, lancement de commandes, relevé | haiku (agent intégré `Explore` pour lire) |
| Code, tests, documentation | sonnet |
| Conception, ADR, exactitude métier, rétrospective | opus |

## Brief de délégation
Un sous-agent ne voit pas la conversation. Cinq rubriques :
1. **Objectif** : le résultat attendu, en une phrase.
2. **Contexte** : fichiers **et plages de lignes** utiles, décisions déjà prises, commandes ; l'agent ne relit pas ce
   que tu as déjà trouvé.
3. **Périmètre** : fichiers qu'il peut modifier ; tout le reste est interdit.
4. **Critère de fin** : une vérification qu'on peut lancer.
5. **Compte rendu** : fait, fichiers, vérifié (commande -> résultat réel), reste et risques, 15 lignes au plus.

## Règles de coût
- Fichier de plus de 300 lignes : `Grep -n`, puis Read avec plage. Ne jamais relire un fichier non modifié.
- Un dossier = un propriétaire ; deux agents ne modifient jamais le même fichier en même temps. Parallèle seulement
  sur des fichiers disjoints.
- Fil long = cache relu à chaque tour : après 60 tours ou une pause de plus de 5 minutes, nouvel agent briefé avec le
  compte rendu (pas de `SendMessage`). Un chantier = une session ; `/clear` à la fin.
- Garder peu d'agents et de skills : leur nom et leur description sont chargés à chaque tour.
- Un compte rendu sans commande ni résultat réel ne prouve rien ; « terminé » exige une sortie de commande.
- Un agent qui échoue deux fois sur la même tâche : changer d'approche, pas insister.
- Mesurer avant de corriger : tokens dédoublonnés par `message.id` dans les transcripts (agent `coach-equipe`).
