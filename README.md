# Deploy_WebSite
Déploiement automatisé du site web avec création de l'ELB, de l'ASG et des scaling policies.

NB : main.tf.old correspond à notre ancien main.tf (avant l'organisation en modules).

## Organisation des fichiers
- DeployWebSite_Jenkinsfile : code du pipeline de déploiement sur Jenkins
- main.tf et variables.tf : servent au lancement de Terraform. Main.tf s'appuie sur les modules suivants :
  - asg
  - elb
  - scaling_policies

Chaque module est composé de son propre main.tf & variables.tf. 
Un fichier output.tf permet de rendre la ressource disponible dans un autre module.
