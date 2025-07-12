variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique, lowercase, no underscores)"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container to store the remote state"
  type        = string
}

variable "kubernetes_cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
  default     = "akscluster1100"
}

variable "node_count" {
  type    = number
  description = "Number of nodes in the default AKS node pool"
  default = 1
}

variable "vm_size" {
  type    = string
  description = "VM size for the AKS worker nodes"
  default = "Standard_DS2_v2"
}