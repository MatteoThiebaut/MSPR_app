# # PayeTonKawa Application
Projet Flutter

# # Auth.dart
Au lancement de l'application, on arrive sur la page de connexion. Le formulaire de connexion gère les erreurs en refusant tout format différent de celui accepté pour une adresse e-mail. Pour montrer cette erreur, le cadre du formulaire devient rouge en précisant que le format écrit n'est pas adapté. 

À chaque pression du bouton, l'application appelle l'API fournie par notre backend. Nous envoyons une méthode POST contenant l'adresse e-mail tapée dans le formulaire. Le backend nous retourne un texte que nous pouvons vérifier avec l'application afin de rediriger ou non l'utilisateur.

Si l'adresse e-mail n'est pas présente dans l'API, un texte apparaît en rouge sous le bouton afin de montrer à l'utilisateur que cette adresse e-mail n'existe pas.

Ensuite, si l'adresse existe, l'utilisateur reçoit un e-mail contenant le QR code (géré par le backend à réception de la méthode POST). Nous le redirigeons ensuite vers la page de scan de QR code afin de le scanner.

# # Qrcode.dart
La page de scan de QR code affiche un bouton pour ouvrir l'appareil photo du téléphone. En scannant le QR code, nous comparons l'adresse e-mail tapée avec l'adresse e-mail envoyée par l'API. Si les deux correspondent, nous redirigeons l'utilisateur vers la page de liste des produits.

# # product.dart
Liste de tous les produits.

# # fiche.dart
Fiche produit lorsque l'on appuie sur un produit. Un bouton "voir produit" ouvre la caméra pour voir le produit en réalité augmentée.

# # main.dart
Gère toute la navigation entre les pages et le thème contenant les couleurs et autres...

# # testMachine.dart

- Test de la conversion JSON vers l'objet Machine et vice versa pour s'assurer que les données sont correctement sérialisées et désérialisées.
- Test du rendu correct des machines sur l'écran MachineScreen en vérifiant si les informations telles que le nom, le prix, la description, la couleur et le stock sont affichées correctement.
- Test de la navigation vers la page ProductPage lorsqu'on appuie sur une machine spécifique dans MachineScreen. 

# # secondTestMachine.dart 

- Test du chargement des machines à partir de l'API en utilisant fetchMachines.
- Test de la conversion de JSON en objet Machine à l'aide de la méthode fromJson.
- Test de la conversion d'un objet Machine en JSON à l'aide de la méthode toJson.
- Test du rendu des détails de la machine dans MachineScreen.
- Test de la navigation vers ProductPage lorsqu'une machine est tapée dans MachineScreen.
