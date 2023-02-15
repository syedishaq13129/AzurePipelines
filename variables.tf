######################
#provider variable
#####################


variable "subscriptionid" {
  type = string
  default = "fe3657e2-c035-4362-a38d-3e9d29aeac7e"

}
variable "tenantid" {
  type = string
  default = "9b150862-53b2-45c1-816e-0d6b231cf238"

}
variable "clientid" {
  type = string
  default = "94f8bcb6-ef10-4589-8720-929a4ad2121d"

}
variable "clientsecret" {
  type = string
  default = "wJZ8Q~IIFt_Qo7MQdti_SEC2fzgx7oUEhPut5bUO"

}

variable "backendstgrg" {
  type = string
  default = "terrastorage"

}


###############################

variable "rgname" {
    type = string
    default = "demo-rg1"
  }

variable "location" {
    type = string
    default = "Central India"
  }

variable "tag" {
    type = string
    default = "Dev"
  }

variable "demovnet" {
    type = string 
    default = "demovn"
  }

  variable "address_space" {
    default = ["10.1.0.0/16"]
   }

   variable "dnsservers" {
    default = ["10.1.0.4"]
   } 

variable "subnetname" {
        default = "subnet0"
}   

variable "address_prefixes" {
 default = ["10.1.1.0/24"]
  
}

variable "nsg-name" {
    type = string
    default = "demo-nsg"
  
}


########NSGrule#############

variable "NSGrulename" {
    type = string
    default = "test123"
    }
variable "nsgprirority" {
    type = number
    default = 300  
}
variable "nsgdirection" {
    type = string
    default = "Inbound"  
}
variable "access" {
    type = string
    default = "Allow"  
}
variable "nsgprotocol" {
    type = string
    default = "Tcp"
  }
variable "sdnsgportrange" {
    type = string
    default = "*"     
}
variable "ddnsgportrange" {
    type = string
    default = "*"     
}
variable "snsgsaddressprefix" {
    type = string
    default = "*"  
}

variable "daddressprefix" {
    type = string
    default = "*"
  }

####################
#storageacctount
################
variable "storageaccount" {
    type = string
    default = "storageacc8888"
  
}

variable "storagetier" {
    type    = string
    default = "Standard"  
}

variable "stgreplicationtype" {
    type = string
    default = "LRS"
  
}

###############
#stgendpoint
##############
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


####################################
#Postgressql
####################################

variable "postgresname" {
  type = string
  default = "postgresqlserver99"
}
variable "postgskuname" {
  type = string
  default = "GP_Gen5_2"
}
variable "postgrstorage" {
  type = number
  default = 5120
}
variable "postgrsbackup" {
  type = number
  default = 7
}
variable "postgrsredundant" {
  type = string
  default = "false"
}
variable "postgrsautogrow" {
  type = string
  default = "true"
}

variable "postgrsadmin" {
  type = string
  default = "psqladmin"
}
variable "postgrspass" {
  type = string
  default = "H@Sh1CoR3!"
}
variable "postgrsversion" {
  type = number
  default = 11
}
variable "postgrsssl" {
  type = string
  default = "true"
}

variable "postdbname" {
  type = string
  default = "dbprod"
}
variable "postdbcharset" {
  type = string
  default = "UTF8"
}
variable "postdbcollation" {
  type = string
  default = "English_United States.1252"
}

################
#postgres private endpoint
########################

variable "postpriendptname" {
  type = string
  default = "Psql-endp1"
}

variable "postpriendptservicecon" {
  type = string
  default = "psql-private-service-connection"
}
variable "postpriendptsubresource" {
    default = ["postgresqlServer"]
}



##########
#Kubernetes
###############3

variable "kubename" {
  type = string
  default = "demo-aks1"
}

variable "kubednsprefix" {
  type = string
  default = "aks-dns1"
}
variable "nodepool" {
  type = string
  default = "default"
}
variable "nodecount" {
  type = number
  default = 1
}
variable "kvmsize" {
  type = string
  default = "Standard_B2s"
}
variable "kubeidentity" {
  type = string
  default = "SystemAssigned"
}

