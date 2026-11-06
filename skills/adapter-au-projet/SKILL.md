---
name: adapter-au-projet
description: Adapte l'équipe d'agents à un dépôt. Analyse pile, dossiers et tests, propose des agents de projet, rédige CLAUDE.md et carte de propriété. À utiliser sur un nouveau projet.
---
# Adapter l'équipe à un projet

À lancer en mode plan : propose, puis écris seulement après accord de l'utilisateur. Ne touche pas à `~/.claude`.

## 1. Analyser (lecture seule, agent `Explore` si le dépôt est gros)
- Pile : fichiers de manifeste (package.json, pyproject.toml, Cargo.toml, go.mod, *.csproj, docker-compose...).
- Dossiers principaux et ce qu'ils contiennent (code, tests, docs, infra, données, contenus rédigés).
- Commandes de test, de lint et de lancement (scripts, Makefile, CI) : lance-les une fois pour vérifier qu'elles marchent.
- Existant : CLAUDE.md, `.claude/`, README.

## 2. Proposer les agents
L'équipe générique du plugin (orchestrateur, architecte, developpeur, qa-reviewer, documentaliste, coach-equipe)
suffit pour un petit projet : ne crée rien. Ajoute un agent de projet seulement si un dossier a des règles propres
et un volume de travail récurrent. Exemples : frontend, backend, data, infra, rédaction, tests e2e.
Chaque agent proposé : nom, dossiers possédés (un dossier = un propriétaire), modèle (haiku mécanique, sonnet code,
opus conception), outils minimaux, règles propres au dossier. Quatre à six agents de projet au maximum.

## 3. Écrire dans `.claude/agents/<nom>.md` du projet
```
---
name: <nom, identique au fichier>
description: <déclencheurs, une à deux phrases, sans deux-points>
tools: Read, Glob, Grep, Edit, Write, Bash
model: sonnet
---
<rôle, dossiers possédés, règles, commande de vérification, format de compte rendu>
```
Un agent de projet du même nom masque celui du plugin (`developpeur`, par exemple).
Ne fixe jamais `permissionMode`, `hooks` ni `mcpServers` dans un agent de plugin : ils sont ignorés.

## 4. Rédiger le CLAUDE.md du projet (court, il est chargé à chaque session)
- Une ligne de description et les contraintes du projet.
- Commandes : lancer, tester, linter, avec le résultat attendu.
- Carte de propriété : tableau agent / modèle / possède / à lui pour.
- Règles d'organisation : brief en cinq rubriques (skill `regles-equipe`), fin de chantier = `qa-reviewer`, puis
  `documentaliste` si une commande ou un contrat a changé.
- Où lire en premier (docs, ADR).

## 5. Valider
- Frontmatter de chaque agent lisible en YAML ; description sans « : ».
- Les commandes du CLAUDE.md ont été lancées, pas recopiées de mémoire.
- Rendre compte : fichiers créés, agents proposés et pourquoi, ce qui reste à décider.

Activer l'orchestrateur sur le projet est un choix de l'utilisateur (`.claude/settings.json` : `"agent":
"team-for-every-project:orchestrateur"`) : recommande-le seulement pour un projet qui a plusieurs domaines.
