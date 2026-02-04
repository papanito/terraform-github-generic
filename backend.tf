terraform {
  required_version = ">= 1.10.0, < 2.0.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.8.3, < 7.0.0"
    }
  }
}

