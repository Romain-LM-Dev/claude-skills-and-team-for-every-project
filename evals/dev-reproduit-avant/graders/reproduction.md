---
type: llm
---

PASS si le compte rendu montre les deux étapes de la reproduction :
1. Avant le correctif : une commande ou un test qui échoue sur `moyenne([])` (ZeroDivisionError ou test en échec),
   avec sa sortie ou son résultat.
2. Après le correctif : la même vérification qui passe, avec son résultat.

FAIL si le compte rendu ne cite pas d'échec avant le correctif, ou affirme que c'est corrigé sans résultat de commande.
