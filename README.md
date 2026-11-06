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
| skill `regles-equipe` | règles de coût, choix du modèle, brief en cinq rubriques (préchargée par l'orchestrateur) | - |
| skill `adapter-au-projet` | analyse un dépôt, propose des agents de projet, rédige le CLAUDE.md | - |
| skill `business-game-designer` | conception de business games et de simulations de formation | - |

Pour l'exploration en lecture seule, utiliser l'agent intégré `Explore` (haiku), il n'y en a pas de copie ici.

## Installation dans Claude Code

Dans une session, une fois le dépôt publié :

```
/plugin marketplace add <compte-github>/claude-skills-and-team-for-every-project
/plugin install team-for-every-project@skills-and-team
```

Sans installer, pour un essai local : `claude --plugin-dir <dossier-du-dépôt>`.
Les agents du plugin s'appellent `team-for-every-project:orchestrateur`, etc. Un agent de projet ou d'utilisateur de
même nom les masque (priorité la plus basse pour le plugin).

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

## Utiliser les skills dans claude.ai

Les agents et les hooks ne tournent pas dans le chat claude.ai ; seules les skills s'y importent, par ZIP.

```powershell
.\scripts\package-skills.ps1
```

Le script écrit un ZIP par skill dans `dist/` (ignoré par git), après avoir vérifié `name` (64 caractères au plus,
identique au dossier) et `description` (200 au plus). Puis, dans claude.ai : Customize, Skills, Upload, et choisir le ZIP.
La skill `regles-equipe` y est utile surtout comme aide-mémoire.

## Validation

```
claude plugin validate .
claude plugin validate . --strict
```

## Licence

Licence source-available non commerciale : voir `LICENSE.md`. Usage commercial sur autorisation écrite du titulaire.
