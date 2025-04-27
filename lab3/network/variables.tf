variable "env" {
  description = "specify enviomrent"
  type = string
}

variable "vpc_cidr_block" {
  description = "define vpc cider block"
  type = string
}

variable "subnets" {
  description = "define subnets"
  type = list(object({
    name =  string
    availability_zone =  string
    cidr_block = string
    public = bool
  }))
}
