variable access_key {
    type = string
}

variable secret_key {
    type = string
}

# This pertains to the VPC section
variable allCIDRblock {
    default = "0.0.0.0/0"
}

variable vpcCIDRblock {
    default = "10.0.0.0/16"
}

variable vpcname {
    default = "Production"
}

variable pub1CIDRblock {
    default = "10.0.0.0/20"
}

variable pub1name {
    default = "Prod-Public-1a"
}

variable pvt1CIDRblock {
    default = "10.0.16.0/20"
}

variable pvt1name {
    default = "Prod-Private-1a"
}

variable pub2CIDRblock {
    default = "10.0.32.0/20"
}

variable pub2name {
    default = "Prod-Public-1b"
}

variable pvt2CIDRblock {
    default = "10.0.48.0/20"
}

variable pvt2name {
    default = "Prod-Private-1b"
}

variable region {
    default = "eu-west-1"
}

variable az1 {
    default = "eu-west-1a"
}

variable az2 {
    default = "eu-west-1b"
}

variable route1name {
    default = "ProductionCustom1a"
}

variable route2name {
    default = "ProductionCustom1b"
}

# Name of the Key Pair that was manually set up
variable keyname {
    default = "productionkp"
}