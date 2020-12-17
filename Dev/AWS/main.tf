

module "requestor_network" {
    source = "../../Modules/AWS/Network"
    global_tags = merge(
        {
            "Network" = "Requestor Network"
        },
        var.global_tags,
    )
    resource_name = "requestor_net" 
    vpc_cidr_block = "${var.vpc_cidr_block_1}"
    default_sg_rules_ingress = "${var.default_sg_rules_ingress}"
    default_sg_rules_egress = "${var.default_sg_rules_egress}"
    vpc_cidr_base = "${var.vpc_cidr_base_1}"
    az_count = "${var.az_count}"
    aws_azs = "${var.aws_azs}"
    private_subnet_cidrs = "${var.private_subnet_cidrs_1}"
    private_outbound_acl_rules = "${var.private_outbound_acl_rules}"
    private_inbound_acl_rules = "${var.private_inbound_acl_rules}"
}

module "acceptor_network" {
    source = "../../Modules/AWS/Network"
    global_tags = merge(
        {
            "Network" = "Acceptor Network"
        },
        var.global_tags,
    )
    resource_name = "acceptor_net" 
    vpc_cidr_block = "${var.vpc_cidr_block_2}"
    default_sg_rules_ingress = "${var.default_sg_rules_ingress}"
    default_sg_rules_egress = "${var.default_sg_rules_egress}"
    vpc_cidr_base = "${var.vpc_cidr_base_2}"
    az_count = "${var.az_count}"
    aws_azs = "${var.aws_azs}"
    private_subnet_cidrs = "${var.private_subnet_cidrs_2}"
    private_outbound_acl_rules = "${var.private_outbound_acl_rules}"
    private_inbound_acl_rules = "${var.private_inbound_acl_rules}"
}

module "vpc_peering" {
  source                                    = "../../Modules/AWS/Peering"
  global_tags                               = var.global_tags
  auto_accept                               = true
  requestor_allow_remote_vpc_dns_resolution = true
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_vpc_id                          = module.requestor_vpc.aws_vpc
  acceptor_vpc_id                           = module.acceptor_vpc.aws_vpc
  create_timeout                            = "5m"
  update_timeout                            = "5m"
  delete_timeout                            = "10m"
}

module "storge" {
    source = "../../Modules/AWS/Storage"
    global_tags = "${var.global_tags}"
    s3_storage_name = "${var.s3_storage_name}"
}

