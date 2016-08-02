variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "network_interface_ids" {}
variable "vm_size" {}

variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_version" {}

variable "os_disk_name" {}
variable "os_disk_vhd_uri" {}
variable "os_disk_caching" {}
variable "os_disk_create_option" {}

variable "data_disk_name" {}
variable "data_disk_vhd_uri" {}
variable "data_disk_create_option" {}
variable "data_disk_size_gb" {}
variable "data_disk_lun" {}

variable "os_profile_computer_name" {}
variable "os_profile_username" {}
variable "os_profile_password" {}

variable "disable_password_authentication" {}
variable "ssh_keys_path" {}
variable "ssh_keys_key_data" {}
