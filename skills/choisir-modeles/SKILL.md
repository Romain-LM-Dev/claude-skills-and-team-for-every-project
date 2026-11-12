---
name: choisir-modeles
description: Revoit le modèle et l'effort de chaque agent de l'équipe quand un modèle sort. Mesure avec les évals et garde le réglage le moins cher qui tient la qualité.
disable-model-invocation: true
---
# Choisir les modèles de l'équipe

But : pour chaque rôle, le modèle et l'effort les moins coûteux qui tiennent la qualité mesurée. Rien ne change sans
mesure ; « garder » est un résultat valide.

## 1. Ce qui évolue seul
Les alias `haiku`, `sonnet`, `opus` et `fable` suivent la version recommandée de leur famille : une nouvelle version
est prise sans rien faire. Cette revue sert quand les rangs bougent : nouvelle famille, baisse de prix, petit palier
qui rattrape le palier au-dessus.

## 2. Inventaire
- Modèles et prix du jour : charge la skill `claude-api` (tableau tenu à jour avec Claude Code) et note sa date.
- Réglage actuel : `model` et `effort` du frontmatter de chaque agent, puis les surcharges (ligne `Modèles :` du
  CLAUDE.md du projet, `~/.claude/rules/modeles-equipe.md`).
- Dernière revue : section « Modèles » du README du plugin, ou `docs/equipe/modeles.md` du projet.
- Coût réel par agent : skill `mesure-equipe` (`report` donne modèle, effort et tokens de chaque run).

## 3. Candidats
Par rôle, trois réglages au plus : l'actuel, le palier en dessous, et le nouveau modèle s'il vise ce rôle. À modèle
égal, essaie d'abord l'effort plus bas. Ne monte d'un palier que si l'actuel échoue à une éval.

## 4. Mesurer
Un rôle sans cas dans `evals/` garde son réglage ; pour le changer, écris d'abord un cas (consigne et juge).
Annonce le coût estimé (environ 0,10 $ par exécution) et attends l'accord. Pour chaque candidat, depuis le dossier du
plugin, en PowerShell :
```
$env:CLAUDE_CODE_SUBAGENT_MODEL = '<alias>'; $env:CLAUDE_CODE_SUBAGENT_MODEL_FORCE = '1'
$env:CLAUDE_CODE_EFFORT_LEVEL = '<effort>'   # facultatif
claude plugin eval . --case <cas> --ablation none --no-publish --trust-plugin --runs 3 --allow-tools Write Edit --json <fichier>
```
Le forçage s'applique à tous les sous-agents de l'éval ; la session qui délègue garde son modèle, donc les coûts se
comparent entre eux. Sous Windows, un cas qui demande Bash ne tourne pas : passer par WSL.

## 5. Décider et appliquer
- Garde le candidat le moins cher dont le score égale celui de l'actuel sur tous les cas du rôle ; compare le coût
  par tâche réussie, pas par requête.
- Baisser une porte de qualité (`qa-reviewer`, `architecte`, `game-designer`) demande au moins deux cas.
- Applique selon la portée choisie par l'utilisateur :
  - tous ses projets : `~/.claude/rules/modeles-equipe.md`, ligne `Modèles : <agent> <alias> <effort>, ...` ;
  - un projet : la même ligne dans son CLAUDE.md ;
  - tous les utilisateurs du plugin : le frontmatter de l'agent, dans une nouvelle version du plugin.
- Note la revue (section « Modèles » du README du plugin, ou `docs/equipe/modeles.md`) : date, version de Claude
  Code, tableau rôle / réglage / score / coût, décision.

Compte rendu : réglages mesurés (score, coût), décisions, ce qui reste à mesurer faute de cas.
