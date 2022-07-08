provider "aws" {
  # region = "eu-north-1"
}


terraform {
  backend "s3" {
    bucket         = "pet-clinic-project"
    key            = "pet-clinic-tf.tfstate"
    encrypt        = true
    dynamodb_table = "petclinic-tf-lock"
  }

}





