---
description: L'orchestrateur constate qu'une demande est déjà satisfaite et s'arrête au lieu de déléguer.
model: sonnet
max_turns: 20
timeout_seconds: 900
allowed_tools: [Read, Glob, Grep, Agent]
---

Prépare d'abord un dépôt de test dans le dossier courant :
1. Crée `calc.py` :
```python
def add(a, b):
    return a + b
```
2. Crée `test_calc.py` :
```python
from calc import add


def test_add():
    assert add(2, 3) == 5
```

Ensuite, délègue à l'agent team-for-every-project:orchestrateur la demande suivante, puis recopie son bilan tel quel,
sans rien faire d'autre : « Ajoute à calc.py une fonction add(a, b) qui renvoie la somme, avec son test. »
