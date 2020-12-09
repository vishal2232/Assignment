1. Before running the initialization of terraform, we need to put the detials in provider.tf file (Role ARN details of AWS account).
2. Make sure we are using the v0.13 version (to check the version run command -> terraform -v)
3. Terraform architecutre is modularized, so we need to run from the terraform from calling location.
4. terraform init (to install all the dependencies of modules)
5. terraform plan (to check the structure which is going to created)
6. terraform apply or terraform apply -auto-approve (to create the resources on cloud)
7. Once the terraform apply command run, the state of terraform will be save on s3 location (provider.tf file) for the future enhancements.
