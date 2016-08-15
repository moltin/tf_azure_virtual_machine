# Virtual Machine Terraform module

A Terraform module to provide a Virtual Machine on Microsoft Azure.

# Setup

- `name` - The name of the virtual network.
- `location` - The location/region where the virtual network is created.
- `resource_group_name` - The name of the resource group in which to create the virtual network.
- `network_interface_ids` - Specifies the list of resource IDs for the network interfaces associated with the virtual machine.
- `vm_size` - Specifies the size of the virtual machine.

- `image_publisher` - Specifies the publisher of the image used to create the virtual machine.
- `image_offer` - Specifies the offer of the image used to create the virtual machine.
- `image_sku` - Specifies the SKU of the image used to create the virtual machine.
- `image_version` - Specifies the version of the image used to create the virtual machine.

- `os_disk_name` - Specifies the disk name.
- `os_disk_vhd_uri` - Specifies the vhd uri.
- `os_disk_caching` - Specifies the caching requirements.
- `os_disk_create_option` - Specifies how the virtual machine should be created. Possible values are attach and FromImage.

- `os_profile_computer_name` - Specifies the name of the virtual machine.
- `os_profile_username` - Specifies the name of the administrator account.
- `os_profile_password` - Specifies the password of the administrator account.

- `disable_password_authentication` - Specifies whether password authentication should be disabled.
- `ssh_keys_path` - Specifies a collection of path and key_data to be placed on the virtual machine.
- `ssh_keys_key_data` - Specifies a collection of path and key_data to be placed on the virtual machine.

> Note: That there are two flavors of this repo one with and without a `data disk` check source on the module `github.com/moltin/tf_azure_virtual_machine//with_data_disk`, the one without won't need the `os_disk_*` variables.

# Run

```js
module "virtual_machine" {
    source = "github.com/moltin/tf_azure_virtual_machine//with_data_disk"

    name = "${var.app_name}_${var.vm_name}"
    location = "${var.location}"
    resource_group_name = "${module.resource_group.name}"
    network_interface_ids = "${module.network_interface.id}"
    vm_size = "${var.vm_size}"

    image_publisher = "${var.image_publisher}"
    image_offer = "${var.image_offer}"
    image_sku = "${var.image_sku}"
    image_version = "${var.image_version}"

    os_disk_name = "${var.app_name}_${var.os_disk_name}"
    os_disk_vhd_uri = "${module.storage_account.primary_blob_endpoint}${module.storage_container.name}/${var.app_name}-${var.os_disk_vhd_uri_name}.vhd"
    os_disk_caching = "${var.os_disk_caching}"
    os_disk_create_option = "${var.os_disk_create_option}"

    data_disk_name = "${var.app_name}_${var.data_disk_name}"
    data_disk_vhd_uri = "${module.storage_account.primary_blob_endpoint}${module.storage_container.name}/${module.storage_blob.name}"
    data_disk_create_option = "${var.data_disk_create_option}"
    data_disk_size_gb = "${var.data_disk_size_gb}"
    data_disk_lun = "${var.data_disk_lun}"

    os_profile_computer_name = "${var.os_profile_computer_name}"
    os_profile_username = "${var.os_profile_username}"
    os_profile_password = "${var.os_profile_password}"

    disable_password_authentication = "${var.disable_password_authentication}"
    ssh_keys_path = "/home/${var.os_profile_username}/.ssh/authorized_keys"
    ssh_keys_key_data = "${file("${var.ssh_keys_key_data_path}")}"
}
```

## Outputs

 - `id` - The virtual machine ID.

# Resources

 - [Terraform Microsoft Azure Resource Manager - Virtual machine](https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html)
