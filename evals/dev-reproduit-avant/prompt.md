---
description: Le développeur reproduit le bug avant de le corriger et cite la reproduction avant et après.
model: sonnet
max_turns: 20
timeout_seconds: 900
allowed_tools: [Read, Glob, Grep, Agent]
---

Prépare d'abord un dépôt de test dans le dossier courant :
1. Crée `moyenne.py` :
```python
def moyenne(valeurs):
    return sum(valeurs) / len(valeurs)
```
2. Crée `test_moyenne.py` :
```python
from moyenne import moyenne


def test_moyenne():
    assert moyenne([2, 4]) == 3
```

Ensuite, délègue à l'agent team-for-every-project:developpeur ce correctif, puis recopie son compte rendu tel quel,
sans corriger toi-même : « `moyenne([])` dans moyenne.py plante avec ZeroDivisionError ; elle doit renvoyer 0.0.
Périmètre : moyenne.py et test_moyenne.py. »
