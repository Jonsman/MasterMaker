packer {
  required_plugins {
    vsphere = {
      version = "~> 1"
      source  = "github.com/hashicorp/vsphere"
    }
      ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

source "vsphere-iso" "windows-desktop-ent" {
  # vCenter Server
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = true

  # vSphere Settings
  datacenter          = var.vsphere_datacenter
  cluster             = var.vsphere_cluster
  datastore           = var.vsphere_datastore

  # Mount Windows and VMware Tools ISOs
  iso_paths           = [
    "[${var.vsphere_datastore}] ${var.windows_iso_path}",
    "[${var.vsphere_datastore}] ${var.vmtools_iso_path}"
    ]

  # VM Configuration
  vm_name             = "PackerWindows"
  guest_os_type       = "windows11_64Guest"
  CPUs                = 4
  RAM                 = 8192
  network_adapters {
    network = var.vsphere_network
    network_card = "vmxnet3"
  }
  disk_controller_type = ["pvscsi"]
    storage {
      disk_size = 153600
      disk_thin_provisioned = true
    }
  cdrom_type          = "sata"
  usb_controller      = ["xhci"]
  firmware            = "efi-secure"
  vTPM                = true
  #pci_passthrough_allowed_device = "NVIDIA GRID vGPU nvidia_a16-1b"

  # Mount autounattend file for automated Windows install
  cd_files            = ["answer_files/"]

  boot_wait           = "3s"
  boot_command = [
    "<spacebar><spacebar>"
  ]

  # Establish WinRM connection to VM for Packer and different provisioners
  communicator        = "winrm"
  winrm_username      = "packer"
  winrm_password      = "packerpass"
  winrm_use_ssl       = false
  winrm_insecure      = true
  winrm_timeout       = "2h"

  # Finishing touches
  remove_cdrom        = true
  reattach_cdroms     = 1
  convert_to_template = false
  destroy             = false
}

build {
  sources = ["source.vsphere-iso.windows-desktop-ent"]

  # Run Ansible Playbook
  provisioner "ansible" {
    playbook_file = "../ansible/playbooks/vdi_master.yml"
    use_proxy     = false
    user          = "packer"
  }
}
