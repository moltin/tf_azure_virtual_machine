resource "azurerm_virtual_machine" "mod" {
    name = "${var.name}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    network_interface_ids = ["${split(",", var.network_interface_ids)}"]
    vm_size = "${var.vm_size}"

    storage_image_reference {
        publisher = "${var.image_publisher}"
        offer = "${var.image_offer}"
        sku = "${var.image_sku}"
        version = "${var.image_version}"
    }

    storage_os_disk {
        name = "${var.os_disk_name}"
        vhd_uri = "${var.os_disk_vhd_uri}"
        caching = "${var.os_disk_caching}"
        create_option = "${var.os_disk_create_option}"
    }

    os_profile {
        computer_name = "${var.os_profile_computer_name}"
        admin_username = "${var.os_profile_username}"
        admin_password = "${var.os_profile_password}"
    }

    os_profile_linux_config {
        disable_password_authentication = "${var.disable_password_authentication}"
        ssh_keys {
            path = "${var.ssh_keys_path}"
            key_data = "${var.ssh_keys_key_data}"
        }
    }

    connection {
        user = "${var.mod.os_profile.username}"
        type = "ssh"
        host = "${var.ip_address}"
        private_key = "${var.private_key}"
    }

    provisioner "remote-exec" {
        inline = ["${split(",", var.remote_exec_1)}"]
    }

    provisioner "file" {
        source = "${element(split(",", var.sources), count.index)}"
        destination = "${element(split(",", var.destinations), count.index)}"
    }

    provisioner "remote-exec" {
        inline = ["${split(",", var.remote_exec_2)}"]
    }
}
