terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 2.0.1"
    # }
  }

  required_version = ">= 0.14.9"
  backend "s3" {
    bucket  = "unity-demo-state"
    key     = "demo/state"
    region  = "us-east-1"
    profile = "jpl-unity-cs"
  }
}

provider "aws" {
  profile = "jpl-unity-cs"
}

