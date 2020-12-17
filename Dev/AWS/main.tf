

module "network" {
    source = "../Modules/Network"
    global_tags = "${var.global_tags}"
    vpc_cidr_block = "${var.vpc_cidr_block}"
    default_sg_rules_ingress = "${var.default_sg_rules_ingress}"
    default_sg_rules_egress = "${var.default_sg_rules_egress}"
    vpc_cidr_base = "${var.vpc_cidr_base}"
    az_count = "${var.az_count}"
    aws_azs = "${var.aws_azs}"
    public_subnet_cidrs = "${var.public_subnet_cidrs}"
    private_subnet_cidrs = "${var.private_subnet_cidrs}"
    public_outbound_acl_rules = "${var.public_outbound_acl_rules}"
    public_inbound_acl_rules = "${var.public_inbound_acl_rules}"
    private_outbound_acl_rules = "${var.private_outbound_acl_rules}"
    private_inbound_acl_rules = "${var.private_inbound_acl_rules}"
}
