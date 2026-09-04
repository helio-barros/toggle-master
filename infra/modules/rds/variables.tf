variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "databases" {
  type = map(string)
  default = {
    auth      = "auth_db"
    flags     = "flags_db"
    targeting = "targeting_db"
  }
}
