# PayeTonKawa Application

Projet Flutter

## Auth.dart 

Au lancement de l'application on arrive sur la page de connexion. Le formulaire de connexions gère les erreurs en refusant tout format différents de celui accepter pour
une adresse email. Pour montrée cette erreur le cadre du formulaire deviens rouge en précisant que la format écris n'est pas adapté. 


A chaque pression du bouton, l'application appel l'api délivrer par notre back-end. On envoie une methode POST contenant l'addresse email taper 
dans le formulaire. Le back-end nous retourne un texte que l'on peux verifier avec l'applications afin de rediriger ou non l'utilisateur.


Si l'adresse email n'est pas présente dans l'api, un texte apparaît en rouge sous le bouton afin de montrer à l'utilisateur que cette adresse email 
n'existe pas.

Ensuite si l'adresse éxiste ,l'utilisateur reçois un mail contenant le qrcode (gérée par le back-end a récepetion de la methode POST) donc on le redirige vers la page de scan de qrcode afin de scanner celui-ci.

## Qrcode.dart

La page de Scan de Qrcode affiche un bouton pour ouvrir l'appareil photo du téléphone. En scannant le Qrcode on compare l'adresse email taper avec l'adresse email envoyer par l'API.
Si les deux correspondents on redirige l'utilisateur vers la page de liste des produits.



## product.dart

Liste de tout les produits.

## fiche.dart

Fiche produit quand on appuie sur un produit. Un bouton voir produit ouvre la caméra pour voir le produit en réalité augmentée.

## main.dart

Crée tout la nagitions entre les pages et le thème contenantn couleur et autres...
