# =====================================================
# Infraestructura como Codigo (Terraform) - SOLO ENSENANZA
# No se ejecuta en clase (requiere cuenta AWS)
# =====================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "red_clase" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "red-clase-devops"
    Entorno     = "produccion"
    AdministradoPor = "terraform"
  }
}

resource "aws_s3_bucket" "almacen_app" {
  bucket = "devops-clase-utadeo-2026"
  tags = {
    Name    = "almacen-app"
    Entorno = "produccion"
  }
}
