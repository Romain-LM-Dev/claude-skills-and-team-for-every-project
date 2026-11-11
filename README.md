<div align="center">

🇫🇷 Français | 🇬🇧 [English](README.en.md)

</div>

# claude-skills-and-team-for-every-project

Une équipe d'agents Claude Code utilisable dans n'importe quel projet, et des skills importables dans claude.ai.
Principe : peu d'agents, des descriptions courtes, le modèle adapté à la tâche (haiku pour le mécanique, sonnet pour
le code, opus pour la conception), et des briefs complets pour que chaque sous-agent reparte juste.

## Contenu

| Élément | Rôle | Modèle |
|---|---|---|
| agent `orchestrateur` | découpe, délègue, contrôle, rend un bilan ; sans outil d'édition ni shell | celui de la session |
| agent `architecte` | choix transverse, ADR, contrats, plan d'exécution | opus |
| agent `developpeur` | implémente avec ses tests, sur un périmètre précis | sonnet |
| agent `qa-reviewer` | relit le diff, écrit les tests manquants, lance les vérifications | sonnet |
| agent `documentaliste` | docs, CLAUDE.md, `.claude/` du projet, création d'agents de projet | sonnet |
| agent `coach-equipe` | rétrospective mesurée sur les transcripts, trois propositions au plus | opus |
| skill `regles-equipe` | règles de coût, choix du modèle, brief en cinq rubriques, preuve, pause et reprise (préchargée par l'orchestrateur) | - |
| skill `adapter-au-projet` | analyse un dépôt, propose des agents de projet, rédige le CLAUDE.md | - |
| skill `domain-designer` | règles, chiffres, parcours et contenus métier de tout projet, quel que soit le domaine | - |
| skill `mesure-equipe` | mesure de l'équipe sur les transcripts et contrôle de la carte de propriété (préchargée par coach-equipe) | - |

Pour les business games et les simulations de formation, le dépôt frère
[claude-skills-and-team-for-business-game-generation](https://github.com/Romain-LM-Dev/claude-skills-and-team-for-business-game-generation)
ajoute les agents et skills métier ; son plugin dépend de celui-ci et l'installe avec lui.

Un projet peut ajouter ses propres points de relecture dans son CLAUDE.md : `qa-reviewer` les vérifie.

Pour l'exploration en lecture seule, utiliser l'agent intégré `Explore` (haiku), il n'y en a pas de copie ici.

## Installation dans Claude Code

Dans une session, une fois le dépôt publié :

```
/plugin marketplace add Romain-LM-Dev/claude-skills-and-team-for-every-project
/plugin install team-for-every-project@skills-and-team
```

Sans installer, pour un essai local : `claude --plugin-dir <dossier-du-dépôt>`.
Les agents du plugin s'appellent `team-for-every-project:orchestrateur`, etc. Un agent de projet ou d'utilisateur de
même nom les masque (priorité la plus basse pour le plugin).
Les skills préchargées par un agent ne s'appliquent que quand l'agent est lancé en sous-agent par l'orchestrateur.

## Activer l'orchestrateur

Il n'est pas forcé : il coûte plus qu'il n'économise sur une petite tâche. Pour un projet à plusieurs domaines :

- une session : `claude --agent team-for-every-project:orchestrateur` ;
- en permanence pour un projet : dans `.claude/settings.json` du projet, `{ "agent": "team-for-every-project:orchestrateur" }` ;
- pour tous les projets : la même clé dans `~/.claude/settings.json` (déconseillé).

Pour adapter l'équipe à un dépôt, demander : « utilise la skill adapter-au-projet ».

## Coût

Chaque agent et chaque skill ajoute son nom et sa description au contexte de chaque tour : l'ensemble reste volontairement
court. Un sous-agent démarre à froid ; ne lui déléguer que des sorties volumineuses, du travail autonome ou parallèle,
une relecture indépendante. Le détail est dans `skills/regles-equipe/SKILL.md`.

Mesuré le 2026-11-10 avec `claude plugin details team-for-every-project@skills-and-team` : environ 990 tokens
permanents par session, puis de 440 à 2 200 tokens à chaque appel d'un agent ou d'une skill.

## Utiliser les skills dans claude.ai

Les agents et les hooks ne tournent pas dans le chat claude.ai ; seules les skills s'y importent, par ZIP.

```powershell
.\scripts\package-skills.ps1
```

Le script écrit un ZIP par skill dans `dist/` (ignoré par git), après avoir vérifié `name` (64 caractères au plus,
identique au dossier) et `description` (200 au plus). Puis, dans claude.ai : Customize, Skills, Upload, et choisir le ZIP.
La skill `regles-equipe` y est utile surtout comme aide-mémoire.

## Priorité du projet

Claude Code ne départage que les agents de même nom : ceux du plugin (préfixés) coexistent avec ceux du projet. Règle
de l'équipe : un agent ou une skill du projet qui couvre le domaine prime ; ceux du plugin comblent les domaines non
couverts. `adapter-au-projet` note dans le CLAUDE.md quels agents du plugin chaque agent du projet remplace. Si le
projet couvre tous les rôles, désactiver le plugin dans son `.claude/settings.json` :
`"enabledPlugins": {"team-for-every-project@skills-and-team": false}`.

## Validation

```
claude plugin validate .
claude plugin validate . --strict
```

La CI GitHub (`.github/workflows/validate.yml`) lance à chaque push la validation stricte, le packaging des skills
(échec si une skill est ignorée) et l'auto-test de `team_metrics.py`.

## Évaluations

`evals/` contient trois cas qui vérifient le comportement des agents : l'orchestrateur s'arrête sur une demande déjà
satisfaite, `qa-reviewer` range un doute invérifiable dans « Non prouvé », `developpeur` reproduit un bug avant de le
corriger. Chaque exécution consomme des tokens et demande une session connectée : à lancer à la main.

```
claude plugin eval . --ablation none --no-publish --trust-plugin --allow-tools Bash Write Edit --case qa-non-prouve
```

`--ablation none` : sans le plugin, l'agent appelé n'existe pas. `--no-publish` garde le rapport en local
(`evals/results/`, ignoré par git). Bash n'est utile qu'à `dev-reproduit-avant`, qui doit exécuter du code.

## Dépannage

| Symptôme | Cause | Remède |
|---|---|---|
| Agents ou skills d'une ancienne version | mise à jour automatique désactivée par défaut pour une marketplace tierce | `claude plugin update team-for-every-project@skills-and-team`, puis redémarrer |
| Une skill préchargée n'est pas appliquée | l'agent n'a pas été lancé en sous-agent | passer par l'orchestrateur, ou charger la skill avec l'outil Skill |
| `claude plugin prune` propose de supprimer ce plugin | il a été installé comme dépendance de business-game | le réinstaller explicitement : `claude plugin install team-for-every-project@skills-and-team` |

## Licence

Licence source-available non commerciale : voir `LICENSE.md`. Usage commercial sur autorisation écrite du titulaire.
