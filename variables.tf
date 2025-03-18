# variable "vm_name" {
#   type = string
#   description = "This is the name for the virtual machine"
# }
# variable "admin_username" {
#   type = string
#   description = "This is th admin username for the virtual machine"
# }
#
# variable "vm_size" {
#   type = string
#   description = "This is the size of the machine"
#   default = "Standard_B2s"
# }
#
# variable "admin_password" {
#   type = string
#   description = "This is the admin password for the virtual machine"
#   sensitive = true
# }

variable "network_inteface_count" {
  type=number
  description = "This defines the number of network interfaces to create"
}