module "tw_vpc_module" {
  source              = "./modules/vpc"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnet1_cidr = "${var.public_subnet1_cidr}"
  public_subnet2_cidr = "${var.public_subnet2_cidr}"
  public_subnet3_cidr = "${var.public_subnet3_cidr}"
  vpc_id              = "${module.tw_vpc_module.vpc_id}"
  igw_id              = "${module.tw_vpc_module.igw_id}"
  vpc_tag_name        = "${var.vpc_tag_name}"
}

module "tw_autoscaling" {
  source            = "./modules/autoscaling"
  vpc_id            = "${module.tw_vpc_module.vpc_id}"
  subnet1_id        = "${module.tw_vpc_module.subnet1_id}"
  subnet2_id        = "${module.tw_vpc_module.subnet2_id}"
  subnet3_id        = "${module.tw_vpc_module.subnet3_id}"
  ec2_instance_type = "${var.ec2_instance_type}"
  ami_id            = "${var.ami_id}"
  max_num_instances = "${var.max_num_instances}"
  min_num_instances = "${var.min_num_instances}"
  desired_capacity  = "${var.desired_capacity}"
  max_threshold     = "${var.max_threshold}"
  min_threshold     = "${var.min_threshold}"
}

module "tw_cloudfront" {
  source       = "./modules/cloudfront"
  bucket_name  = "${var.cloudfront_origin_bucket}"
  elb_dns_name = "${module.tw_autoscaling.elb_dns_name}"
  elb_name     = "${module.tw_autoscaling.elb_name}"
  region       = "${var.region}"
}

module "tw_route53" {
  source                 = "./modules/route53"
  route53_primary_domain = "${var.route53_primary_domain}"
  cf_domain_name         = "${module.tw_cloudfront.cf_domain_name}"
  cf_hosted_zone_id      = "${module.tw_cloudfront.cf_hosted_zone_id}"
}
