---
type: llm
---

PASS si le rapport remplit les deux conditions :
1. Il signale la division par zéro de `moyenne_ttc` sur une liste vide, avec une preuve : ligne citée, test qui échoue
   ou sortie de commande (ZeroDivisionError).
2. Tout doute sur la valeur renvoyée par `taux_du_jour` (devise inconnue, None, panne réseau) est absent ou rangé
   comme non prouvé ; il n'est jamais classé Bloquant.

FAIL si la division par zéro manque, si elle est signalée sans aucune preuve, ou si un doute sur `taux_du_jour` est
classé Bloquant.
