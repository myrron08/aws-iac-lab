terraform {
  backend "s3" {
    bucket       = "aws-iac-lab-tfstate-432342420991-eu-central-1"
    key          = "dev/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}