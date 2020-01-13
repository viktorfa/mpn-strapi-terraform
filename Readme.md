# Terraform Strapi

Run `terraform apply`

You can get the public IP and root user password in the terraform.tfstate file.

You should manually add an ssh-key to the newly created machine.

You can get the passwords for the mongo database in `~/strapi/mongo-passwords.txt`.

Populate `~/strapi/.env.dev` and `~/strapi/.env.prod` with a mongo username and password.

Run `docker-compose up -d` to start Strapi.

You have to edit the DNS at your domain provider with an A record pointing to the IP of the newly created server.
