data "intersight_organization_organization" "org" {
    name = var.organization
}

data "intersight_hyperflex_vcenter_config_policy" "hyperflex_vcenter_config_policy1" {
    name = "${var.env}_HyperFlex_vCenter_Policy"
}

data "intersight_hyperflex_local_credential_policy" "hyperflex_local_credential_policy1" {
    name = "${var.env}_Hyperflex_local_credential_policy"
}

data "intersight_hyperflex_sys_config_policy" "hyperflex_sys_config_policy1" {
    name = "${var.env}_HyperFlex_System_Config_Policy"
}

data "intersight_hyperflex_cluster_storage_policy" "hyperflex_cluster_storage_policy1" {
    name = "${var.env}_HyperFlex_Storage_Cluster_Policy"
}

data "intersight_hyperflex_cluster_network_policy" "hyperflex_cluster_network_policy1" {
    name = "${var.env}_HyperFlex_Cluster_Network_Policy"
}

resource "intersight_hyperflex_node_config_policy" "hyperflex_node_config_policy1" {
  mgmt_ip_range {
    start_addr = "${var.subnet_str}.${var.mgmt_start}"
    end_addr   = "${var.subnet_str}.${var.mgmt_end}"
    gateway    = "${var.subnet_str}.1"
    netmask    = "255.255.255.0"
  }
  hxdp_ip_range {
    start_addr = "${var.subnet_str}.${var.hxdp_start}"
    end_addr   = "${var.subnet_str}.${var.hxdp_end}"
    gateway    = "${var.subnet_str}.1"
    netmask    = "255.255.255.0"
  }
  node_name_prefix = "HX-${var.env}"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "HX-${var.env}_Node_Configuration_Policy"
  description = "Created by Terraform"
}


resource "intersight_hyperflex_ucsm_config_policy" "hyperflex_ucsm_config_policy1" {
  name        = "${var.env}_HyperFlex_UCSM_Configuration_Policy"
  description = "Created by Terraform"
  kvm_ip_range {
    start_addr = "${var.subnet_str}.10"
    end_addr   = "${var.subnet_str}.100"
    gateway    = "${var.subnet_str}.1"
    netmask    = "255.255.255.0"
  }
  server_firmware_version = "4.1(2b)"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

resource "intersight_hyperflex_software_version_policy" "hyperflex_software_version_policy1" {
  hxdp_version = "4.5(1a)"
  server_firmware_version = "4.1(2b)"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "${var.env}_Hyperflex_software_version"
}

resource "intersight_hyperflex_cluster_profile" "hyperflex_cluster_profile1" {
  storage_data_vlan {
    name    = "hx-storage-data"
    vlan_id = 13
  }
  
  software_version {
    moid        = intersight_hyperflex_software_version_policy.hyperflex_software_version_policy1.moid
    object_type = "hyperflex.SoftwareVersionPolicy"
  }
  local_credential {
    moid        = data.intersight_hyperflex_local_credential_policy.hyperflex_local_credential_policy1.results[0].moid
    object_type = "hyperflex.LocalCredentialPolicy"
  }
  sys_config {
    moid        = data.intersight_hyperflex_sys_config_policy.hyperflex_sys_config_policy1.results[0].moid
    object_type = "hyperflex.SysConfigPolicy"
  }
  node_config {
    moid        = intersight_hyperflex_node_config_policy.hyperflex_node_config_policy1.moid
    object_type = "hyperflex.NodeConfigPolicy"
  }

  cluster_network  {
    moid        = data.intersight_hyperflex_cluster_network_policy.hyperflex_cluster_network_policy1.results[0].moid
    object_type = "hyperflex.ClusterNetworkPolicy"
  }
  cluster_storage  {
    moid        = data.intersight_hyperflex_cluster_storage_policy.hyperflex_cluster_storage_policy1.results[0].moid
    object_type = "hyperflex.ClusterStoragePolicy"
  }
  vcenter_config  {
    moid        = data.intersight_hyperflex_vcenter_config_policy.hyperflex_vcenter_config_policy1.results[0].moid
    object_type = "hyperflex.VcenterConfigPolicy"
  }
  
  tags {
    key   = "deployment"
    value = "terraform"
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "HX-TF-${var.env}-01"
  mgmt_ip_address    = "${var.subnet_str}.234"
  mac_address_prefix = "00:25:B5:D5"
  mgmt_platform = "FI"
  replication   = 3
  description   = "This HX Profile is created by Terraform"
  hypervisor_type = "ESXi"
  storage_type    = "HyperFlexDp"
}

