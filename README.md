# Python-Mailer
Automate sending mails using smtplib and email libraries in python

# Run as a docker image container
+ cd app 
+ docker build -t mailer:v001 .
+ docker run -d --env-file=".env" --name mailercontainer --rm mailer:v001 (detach mode)
+ docker run -it --env-file=".env" --name mailercontainer --rm mailer:v001 (interactive mode)

# Create aws lambda function and run in terraform
enter zip file in terraform directory when prompted for zip-file name \
create variables.tf file to reference variables in main.tf 
+ cd terraform_lambda/terraform && touch variables.tf (for windows use; echo > variables.tf)
+ terraform init
+ terraform fmt
+ terraform validate
+ terraform plan
+ terraform apply
