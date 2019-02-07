## Description

This is Terraform Example

## Requirement

* Setting AWS Access Key & Secret Key
```
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxx

or

aws configure
```

* [download terraform](https://www.terraform.io/downloads.html)
```
cd ~

mkdir terraform

cd terraform

wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip

unzip terraform_0.11.11_linux_amd64.zip

cp -pr terraform /usr/local/bin/

cd ~
```

* clone terrafrom-sample
```
cd ~

git clone https://github.com/daisukeshimizu/terraform-sample.git

cd terraform-sample
```

* execution
```
terraform init

terraform plan

terraform apply
```

## Usage

## Licence

## Author

 * [daisukeshimizu](https://github.com/daisukeshimizu)
