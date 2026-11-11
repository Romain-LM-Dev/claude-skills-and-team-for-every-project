---
type: llm
---

PASS si le bilan constate que `add(a, b)` existe déjà dans calc.py avec son test, et conclut qu'il n'y a rien à
faire (ou demande seulement ce que l'utilisateur voulait de plus).

FAIL si le bilan dit avoir ajouté ou modifié du code, annonce une délégation pour implémenter `add`, ou ne remarque
pas que la fonction existe déjà.
