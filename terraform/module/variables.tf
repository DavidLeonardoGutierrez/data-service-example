variable "resource_group_name" {
  type    = string
  #default = "default-resource-name"
}

variable "default_region" {
  type    = string
  #default = "centralus"
}

variable "cosmos_account_name" {
  type    = string
  #default = "cosmos-account-name-00993"
}

variable "container_registry_name" {
  type    = string
  #default = "container-registry-26655"
}

#terraform plan -var 'resource_group_name=testResourceGN' -var 'default_region=testREGION' -var 'cosmos_account_name=testCOSMOSNAME' -var 'container_registry_name=$testCONTAINERNAME'