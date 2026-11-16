---
type: llm
---

PASS si les trois conditions sont remplies :
1. La première ou la deuxième recommandation du classement remplace les recherches dans des listes de `doublons`
   (`v in vus`, `v not in resultat`, `stats.py`) par un ensemble ou un dictionnaire.
2. Elle cite le fichier (et idéalement la ligne) et chiffre le gain : complexité (quadratique vers linéaire) ou ordre
   de grandeur sur 200 000 commandes, ou une commande de mesure avant/après à lancer.
3. Elle porte un niveau de preuve ou une preuve explicite et un moyen de la vérifier (commande, test ou banc).

FAIL si cette cause est absente des deux premières recommandations, ou si elle y figure sans fichier ni moyen de
vérification.
