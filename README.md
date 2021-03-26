# hello_again
 if27 serveur

# Pour déployer le serveur sur votre vm
1. Installez Java
2. Installez Sbt: 
 echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
 curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
 sudo apt-get update
 sudo apt-get install sbt
3. Téléchargez ce projet, entrez ce répertoire et ouvrez un terminal
4. Entrez la commande: sbt
5. Entrez la commande: run
6. Il va occuper la porte de 9000 automatiquement.

# Pour tester
1. La page localhost:9000 => Home page
2. La page localhost:9000 => établir 2 fois de tcp
3. La page localhost:9000/connections => afficher les connexions de tcp établies et pas finies. 

# PS
Pour faciliter le test, je l'ai posé une limite sur les connexion.
Meme si le nombre de limite est à 50, il va toujours le dépasser mais la durée d'attente s'augmente visiblement.
Si vous avez besoin de limiter le nombre, il faut modifier la configuration de linux.

# PS 26/03/2021
Le script /test_scripts/syn_flood.py est pour l'attaque de tcp syn flood.
Pour la réaliser, il faut :
  * Installez scapy.py
  * Arrêter la configuration: sudo sysctl net.ipv4.tcp_syncookies=0
  * Changez l'addresse IP dans le script

Je recommande d'utiliser hping3 pour réaliser l'attaque de http flood en commande:
```
hping3 -S --rand-source --flood -p 9000 IP_ADDR
```
Car il peut générer les connexions avec les addresse IP aléatoires.
