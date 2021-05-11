variable "api_key" {
  type = string
  description = "API Key Id from Intersight"
}
variable "secretkey" {
  type = string
  description = "The path to your secretkey for Intersight OR the your secret key as a string"
}
variable "organization" {
  type = string
  description = "Organization Name"
  default = "default"
}
variable "password" {
    type = string
    description = "Default Password"
}
variable "env" {
    type = string
    description = "Environment"
}
variable "dns_domain_suffix" {
    type = string
    description = "DNS Domain Suffix"
}
variable "subnet_str" {
    type = string
    description = "Subnet String"
}
variable "mgmt_start" {
    type = string
    description = "Start of MGMT IP Range -.-.-.X"
}
variable "mgmt_end" {
    type = string
    description = "End of MGMT IP Range -.-.-.X"
}
variable "hxdp_start" {
    type = string
    description = "Start of HXDP IP Range -.-.-.X"
}
variable "hxdp_end" {
    type = string
    description = "End of HXDP IP Range -.-.-.X"
}
