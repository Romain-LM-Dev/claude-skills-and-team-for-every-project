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

Un projet peut fixer d'autres modèles par rôle dans son CLAUDE.md (budget, qualité) : passe-les dans le paramètre
`model` de l'appel `Agent` (opus, sonnet, haiku ou fable), qui prime sur celui du fichier de l'agent.

## Brief de délégation
Un sous-agent ne voit pas la conversation. Cinq rubriques :
1. **Objectif** : le but de l'utilisateur reformulé et le résultat attendu, en une phrase.
2. **Contexte** : fichiers **et plages de lignes** utiles, décisions déjà prises, commandes ; l'agent ne relit pas ce
   que tu as déjà trouvé.
3. **Périmètre** : fichiers qu'il peut modifier ; tout le reste est interdit.
4. **Critère de fin** : une vérification qu'on peut lancer.
5. **Compte rendu** : fait, fichiers, vérifié (commande -> résultat réel), reste et risques, 15 lignes au plus ;
   chaque affirmation dit si elle est vérifiée, déduite ou supposée.

## Règles de coût
- Fichier de plus de 300 lignes : `Grep -n`, puis Read avec plage. Ne jamais relire un fichier non modifié.
- Un dossier = un propriétaire ; deux agents ne modifient jamais le même fichier en même temps. Parallèle seulement
  sur des fichiers disjoints.
- Fil long = cache relu à chaque tour : après 60 tours ou une pause de plus de 5 minutes, nouvel agent briefé avec le
  brief d'origine, chaque consigne ajoutée depuis et le dernier compte rendu (pas de `SendMessage`, qui perd des
  consignes). Un chantier = une session ; `/clear` à la fin.
- Garder peu d'agents et de skills : leur nom et leur description sont chargés à chaque tour.
- Un agent qui échoue deux fois sur la même tâche : changer d'approche, pas insister.
- Mesurer avant de corriger : tokens dédoublonnés par `message.id` dans les transcripts (agent `coach-equipe`).

## Preuve
- Un compte rendu sans commande ni résultat réel ne prouve rien ; « terminé » exige une sortie de commande.
- Vérifier sur l'artefact réel (fonction lancée, valeur lue, parcours joué), pas sur un indice indirect. « Non
  concluant », ou vérifié ailleurs (test unitaire pour un bug d'intégration), n'est pas un succès : l'écrire tel quel.
- Une vérification qui échoue : soupçonner d'abord la méthode d'observation, ensuite le système.
- Changement risqué (sécurité, migration, données, contrat public) : second `qa-reviewer`, même brief, autre modèle
  (paramètre `model` de l'appel `Agent`). Leur accord est un signal fort ; un désaccord se tranche par une commande.

## Pause et reprise
- Pause (demandée, ou contexte presque plein) : finir ou annuler l'étape en cours, n'en lancer aucune autre. Note de
  reprise dans `docs/equipe/reprise.md` : but, étape, fait et vérifié (commande -> résultat), fichiers modifiés,
  prochaine action, pièges. Aucun commit sans demande.
- Reprise : lire la note, puis l'état du dépôt (`git status`, `git diff --stat`). Les décisions de la note font foi ;
  un « vérifié » hérité se revérifie avant de s'appuyer dessus. Supprimer la note à la fin du chantier.

## Git
- Commit et push seulement sur demande explicite de l'utilisateur, par l'agent que désigne l'orchestrateur.
- Jamais de force-push ni de réécriture d'historique sans accord de l'utilisateur.
- Avant commit : relire `git status` et le diff indexé (`git diff --cached`). Ne jamais committer de secrets (`.env`),
  d'environnements virtuels ni de fichiers locaux de l'équipe (`settings.local.json`).
- Avant push : `git fetch`, puis `git merge-base --is-ancestor origin/<branche> HEAD` ; en cas d'échec, s'arrêter et
  rendre compte.
- Après push : `git status -sb` sans ahead/behind, à citer dans le compte rendu.