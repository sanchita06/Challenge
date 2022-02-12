variable "region" {
    default = "eu-west-2"
}

module "VPC" {
  source = "./VPC"
}

module "load_balancer" {
  source          = "./load_balancer"
  public_subnet_1  = module.vpc.output_public_subnet_1
  public_subnet_2  = module.vpc.output_public_subnet_2
  private_subnet_1 = module.vpc.output_private_subnet_1
  private_subnet_2 = module.vpc.output_private_subnet_2
  vpc_id          = module.vpc.output_vpc
  external_alb_sg = module.vpc.output_external_alb_sg
  internal_alb_sg = module.vpc.output_internal_alb_sg
}

module "database" {
  source            = "./database"
  fe_lc = module.config.fe_lc
  app_lc = module.config.app_lc
  public_subnet_1    = module.vpc.output_public_subnet_1
  public_subnet_2    = module.vpc.output_public_subnet_2
  private_subnet_1   = module.vpc.output_private_subnet_1
  private_subnet_2   = module.vpc.output_private_subnet_2
  out_tg_instances  = module.load_balancer.out_tg_instances

}


module "ec2_instance" {
  source                      = "./ec2_instance"
  public_subnet_1              = module.vpc.output_public_subnet_1
  private_subnet_1             = module.vpc.output_private_subnet_1
  private_subnet_2             = module.vpc.output_private_subnet_2
  output_allow_all          = module.vpc.output_allow_all
  output_private_sg  = module.vpc.output_private_sg
  output_public_sg  = module.vpc.output_public_sg
}


module "database" {
  source                      = "./database"
  private_subnet_1             = module.vpc.output_private_subnet_1
  private_subnet_2             = module.vpc.output_private_subnet_2
  output_database_sg          = module.vpc.output_database_sg
  database_sg                  = module.vpc.database_sg

}
