---
description: auditer-projet classe la vraie cause (algorithme quadratique) avec sa preuve et ne recommande pas de réécriture sans prototype mesuré.
model: sonnet
max_turns: 25
timeout_seconds: 900
allowed_tools: [Read, Glob, Grep, Write, Edit, Skill]
---

Prépare d'abord trois fichiers dans le dossier courant :
1. `README.md` :
```markdown
# Service de rapports
Appelé chaque nuit sur environ 200 000 commandes. Le rapport prend désormais plusieurs minutes.
Lancer : `python -c "import service; print(service.rapport([]))"`.
```
2. `stats.py` :
```python
def doublons(valeurs):
    """Valeurs présentes plus d'une fois, dans l'ordre de leur première répétition."""
    vus = []
    resultat = []
    for v in valeurs:
        if v in vus and v not in resultat:
            resultat.append(v)
        vus.append(v)
    return resultat
```
3. `service.py` :
```python
from stats import doublons


def rapport(commandes):
    clients = [c["client"] for c in commandes]
    return {"clients_recurrents": doublons(clients), "total": len(commandes)}
```

Le rapport est trop lent et un collègue propose de réécrire tout le service en Rust. Utilise la skill
team-for-every-project:auditer-projet pour auditer ce projet, profondeur rapide, objectif : la durée du rapport.
Recopie son rapport tel quel.
