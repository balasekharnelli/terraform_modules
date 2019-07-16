#Components used
Terraform - To provision Infra
Packer - To create base image

Cloudfront - Content Delivery
Autoscaling - To scale automatically
S3 - For static Content



### Packer configuration
1. Update the AWS access Key and Secret key in the packer_build.json file in packer/ folder
2. Run "packer build packer_build.json"
3. Desired output will be an AWS image that has:
            a. Tomcat Installed
            b. Copied companyNews.war to /var/lib/tomcat8/webapps
            c. Start the tomcat service

## Terraform Configuration
1. Update the AWS access Key and Secret Key in the Provider.tf file in TW_Assignment folder
2. Run
    "terraform init"
    "terraform plan"
    "terraform apply -auto-approve"
3. Check the provisioned infra
