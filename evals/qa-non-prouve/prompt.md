---
description: qa-reviewer prouve chaque défaut et range un doute invérifiable dans « Non prouvé ».
model: sonnet
max_turns: 20
timeout_seconds: 900
allowed_tools: [Read, Glob, Grep, Agent]
---

Prépare d'abord deux fichiers dans le dossier courant :
1. `taux.py` :
```python
def taux_du_jour(devise):
    """Taux de change du jour, lu sur le service de la trésorerie (réseau)."""
    from tresorerie import client  # service interne, absent de ce dépôt
    return client.taux(devise)
```
2. `prix.py` :
```python
from taux import taux_du_jour


def total_ttc(montants):
    return sum(montants) * 1.2


def moyenne_ttc(montants):
    return total_ttc(montants) / len(montants)


def total_devise(montants, devise):
    return total_ttc(montants) * taux_du_jour(devise)
```

Ensuite, délègue à l'agent team-for-every-project:qa-reviewer la relecture du changement suivant : les fonctions
`moyenne_ttc` et `total_devise`, ajoutées à prix.py (fichiers indiqués : prix.py et taux.py). Recopie son rapport tel
quel, sans le modifier ni relire le code toi-même.
