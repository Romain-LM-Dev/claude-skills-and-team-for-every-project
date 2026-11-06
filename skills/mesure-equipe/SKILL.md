---
name: mesure-equipe
description: Mesure l'équipe d'agents sur les transcripts de Claude Code (tokens par agent, tours, erreurs d'outil, relances, briefs, éditions hors périmètre) et contrôle la carte de propriété ownership.json. À utiliser pour mesurer l'équipe, préparer une rétro, savoir combien de tokens coûte chaque agent, ou vérifier la carte de propriété.
---
Outil de mesure générique : `team_metrics.py`, dans le dossier de base de ce skill (Python 3.10+, bibliothèque standard).
Il lit les transcripts du projet en lecture seule et sort des agrégats de quelques Ko : ne lis jamais un transcript brut.

Lancement, depuis la racine du projet (sous Windows, si `python` est absent, remplace-le par `py -3`) :
- `python "<dossier de ce skill>/team_metrics.py" report --root .` : rapport Markdown de 80 lignes au plus ; options `--since AAAA-MM-JJ`, `--session <id>`
- `... json --root .` : toutes les données, run par run
- `... run <agentId> --root .` : un run (statistiques, brief, compte rendu final)
- `... check-owners --root .` : valide la carte de propriété contre `.claude/agents/*.md` (OK ou KO ; sautée s'il n'y en a pas)
- `... selftest` : auto-test de l'outil

Options globales, avant la commande :
- `--root` : racine du projet (défaut : dossier courant) ;
- `--transcripts` : dossier des transcripts (défaut : `~/.claude/projects/<chemin du projet, caractères non alphanumériques remplacés par ->`, avec repli sur le dossier parent) ;
- `--ownership` : carte de propriété (défaut : `<root>/.claude/ownership.json`) ;
- `--orchestrator` : nom de l'agent orchestrateur (défaut : `orchestrateur`).

Carte de propriété facultative, `.claude/ownership.json` : `{"version": 1, "agents": {"<agent>": ["src/**"]}, "shared": ["README.md"]}`.
Motifs glob (`*`, `**`, `?`), `!motif` exclut. Sans elle, les éditions hors périmètre s'affichent « n/d ».

Limites : les éditions faites par PowerShell ou Bash ne sont pas vues ; tokens neufs = input + cache_creation + output,
dédoublonnés par `message.id`.
