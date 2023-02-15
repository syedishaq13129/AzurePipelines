variable "priendpname" {
  type = string
  default = "stg-pri-endp1"
}
variable "serconnection" {
    type = string
    default = "Priv-connection1"
  }
variable "pritype" {
  type = string
  default = "false"
}
variable "subresourcename" {
       default = ["blob"]
  
}

variable "location" {
  type = string
}

variable "rgname" {
  type = string
}

variable "subnetid" {
  type = string
}

variable "paasid" {
  type = string
}