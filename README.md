# PayeTonKawa Application

Projet Flutter

## Page de Connexion 

Au lancement de l'application on arrive sur la page de connexion. Le formulaire de connexions gère les erreurs en refusant tout format différents de celui accepter pour
une adresse email. Pour montrée cette erreur le cadre du formulaire deviens rouge en précisant que la format écris n'est pas adapté. 
A chaque pression du bouton, l'application appel l'api délivrer par notre back-end. On envoie une methode POST contenant l'addresse email taper 
dans le formulaire. Le back-end nous retourne un texte que l'on peux verifier avec l'applications afin de rediriger ou non l'utilisateur.
Si l'adresse email n'est pas présente dans l'api, un texte apparaît en rouge sous le bouton afin de montrer à l'utilisateur que cette adresse email 
n'existe pas. Ensuite si l'adresse éxiste ,l'utilisateur reçois un mail contenant le qrcode (gérée par le back-end a récepetion de la methode POST) donc on le redirige vers la page de scan de qrcode afin de scanner celui-ci.

## Page de Qrcode

