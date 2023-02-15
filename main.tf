# terraform block

terraform {
  required_providers{
    azurerm ={
         source = "hashicorp/azurerm"
        version = "3.42.0" 
    }
  }

# backend "azurerm" {
#   resource_group_name = "terrastorage"
# # resource_group_name = var.backendstgrg
#   storage_account_name = "terrastorage8888"  
#   container_name = "terrastate"
#   #subscription_id = "var.subscriptionid"
#   #tenant_id = var.tenantid
#   subscription_id = "f16c79eb-c2f9-43a4-9f23-4ebf82ffe6c9"
#   tenant_id = "c199f4e5-c890-42cd-b0a9-5f2510e0d2c2"
#   access_key = "o8vKyScRwJUDezHcGkynY9LpLvNj8XrxoqQitcciakPxTuqVRnh611UFkjZcKaV52bnR2b6MpQGy+AStDvd7PQ=="
  
# }

}

#provider block

provider "azurerm"  {
  features{}

  subscription_id = var.subscriptionid
  tenant_id = var.tenantid
  client_id = var.clientid
  client_secret = var.clientsecret

}



###########################################################
#demoblock
###########################################################

resource "azurerm_resource_group" "demo-rg1" {
  name     = var.rgname
  location = var.location
}


#vnet configuration
resource "azurerm_virtual_network" "demo-vnet1" {
  name                = var.demovnet
  location            = azurerm_resource_group.demo-rg1.location
  resource_group_name = azurerm_resource_group.demo-rg1.name
  address_space       = var.address_space
  dns_servers         = var.dnsservers

  tags = {
    environment = var.tag
  }

  depends_on = [
    azurerm_resource_group.demo-rg1
  ]
}

############################
#subnet
###############################

  resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  resource_group_name  = azurerm_resource_group.demo-rg1.name
  virtual_network_name = azurerm_virtual_network.demo-vnet1.name
  address_prefixes     = var.address_prefixes
}

####################################
#NSG
#######################################
resource "azurerm_network_security_group" "demo-nsg" {
  name                = var.nsg-name
  location            = azurerm_resource_group.demo-rg1.location
  resource_group_name = azurerm_resource_group.demo-rg1.name

  tags = {
   environment = var.tag
  }
}

###############################

resource "azurerm_network_security_rule" "nsg_rule" {
    name                       = var.NSGrulename
    priority                   = var.nsgprirority
    direction                  = var.nsgdirection
    access                     = var.access
    protocol                   = var.nsgprotocol
    source_port_range          = var.sdnsgportrange
    destination_port_range     = var.ddnsgportrange
    source_address_prefix      = var.snsgsaddressprefix
    destination_address_prefix = var.daddressprefix
    resource_group_name         = azurerm_resource_group.demo-rg1.name
    network_security_group_name = azurerm_network_security_group.demo-nsg.name
  
  }

##############create azure kubernetes cluster################################# 
# resource "azurerm_kubernetes_cluster" "demo-aks1" {
#   name                = var.kubename
#   location            = azurerm_resource_group.demo-rg1.location
#   resource_group_name = azurerm_resource_group.demo-rg1.name
#   dns_prefix          = var.kubednsprefix

#   default_node_pool {
#     name       = var.nodepool
#     node_count = var.nodecount
#     vm_size    = var.kvmsize
#     vnet_subnet_id  = azurerm_subnet.subnet.id
#   }

#   identity {
#     type = var.kubeidentity
#   }
# }
 #<network_profile {
#  network_plugin    = "azure"
#   service_cidr      = "10.1.0.0/16"
 #   dns_service_ip    = "10.1.0.10"
 #   docker_bridge_cidr = "172.17.0.1/16"
  #  pod_cidr           = "10.244.0.0/16"

   # vnet_subnet_id = azurerm_subnet.subnet1.id
  #}

  




################# STorage account #################


resource "azurerm_storage_account" "Storageacc1" {
  name                     = var.storageaccount
  resource_group_name      = azurerm_resource_group.demo-rg1.name
  location                 = azurerm_resource_group.demo-rg1.location
  account_tier             = var.storagetier
  account_replication_type = var.stgreplicationtype

  tags = {
    environment = var.tag
  }
}

output "stgid" {
  description = "storage account id"
  value = azurerm_storage_account.Storageacc1.id
  
}

##################  Private endpoint #######################3
# resource "azurerm_private_endpoint" "stg-pri-endp1" {
#   name                = var.priendpname
#   location            = azurerm_resource_group.demo-rg1.location
#   resource_group_name = azurerm_resource_group.demo-rg1.name
#   subnet_id           = azurerm_subnet.subnet.id

#   private_service_connection {
#     name                           = var.serconnection
#     private_connection_resource_id = azurerm_storage_account.Storageacc1.id
#     is_manual_connection = var.pritype
#         subresource_names     = var.subresourcename
#   }
# }

module "modprivateep" {
  source = "./privateep"
  priendpname = "stg-pri-endp1"
  location = azurerm_resource_group.demo-rg1.location
  rgname=azurerm_resource_group.demo-rg1.name
  subnetid = azurerm_subnet.subnet.id
  paasid= azurerm_storage_account.Storageacc1.id
}


####################################
#Postgressql
####################################
resource "azurerm_postgresql_server" "postgresql-server-1" {
  name                = var.postgresname
  location            = azurerm_resource_group.demo-rg1.location
  resource_group_name = azurerm_resource_group.demo-rg1.name
  #sku_name = "B_Gen4_1"
  #sku_name = "B_Gen5_1"
 
  sku_name = var.postgskuname
  storage_mb                   = var.postgrstorage
  backup_retention_days        = var.postgrsbackup
  geo_redundant_backup_enabled = var.postgrsredundant
  auto_grow_enabled            = var.postgrsautogrow
  administrator_login          = var.postgrsadmin
  administrator_login_password = var.postgrspass
  version                      = var.postgrsversion
  ssl_enforcement_enabled      = var.postgrsssl
}
resource "azurerm_postgresql_database" "sqldb" {
  name                = var.postdbname
  resource_group_name = azurerm_resource_group.demo-rg1.name
  server_name         = azurerm_postgresql_server.postgresql-server-1.name
  charset             = var.postdbcharset
  collation           = var.postdbcollation
}

# resource "azurerm_private_endpoint" "Psql-endp1" {
#   name                = var.postpriendptname
#   location            = azurerm_resource_group.demo-rg1.location
#   resource_group_name = azurerm_resource_group.demo-rg1.name
#   subnet_id           = azurerm_subnet.subnet.id

#   private_service_connection {
#     name                 = var.postpriendptservicecon
#     private_connection_resource_id = azurerm_postgresql_server.postgresql-server-1.id
#     is_manual_connection = var.pritype
#     subresource_names    = var.postpriendptsubresource

#   }
# }

module "modprivateeppsql" {
  source = "./privateep"
  priendpname = "Psql-endp1"
  location = azurerm_resource_group.demo-rg1.location
  rgname=azurerm_resource_group.demo-rg1.name
  subnetid = azurerm_subnet.subnet.id
  paasid= azurerm_postgresql_server.postgresql-server-1.id
  subresourcename=var.postpriendptsubresource
}