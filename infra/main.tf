module "networking" {
  source      = "./modules/networking"
  environment = var.environment
}

module "eks" {
  source             = "./modules/eks"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
}

module "ecr" {
  source = "./modules/ecr"
}

module "rds" {
  source              = "./modules/rds"
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = module.networking.vpc_cidr_block
  private_subnet_ids  = module.networking.private_subnet_ids
}
module "cache" {
  source              = "./modules/cache"
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = module.networking.vpc_cidr_block
  private_subnet_ids  = module.networking.private_subnet_ids
}
module "dynamodb" {
  source      = "./modules/dynamodb"
  environment = var.environment
}
module "messaging" {
  source      = "./modules/messaging"
  environment = var.environment
}

resource "aws_iam_role_policy" "node_sqs_dynamodb" {
  name = "${var.environment}-node-sqs-dynamodb"
  role = module.eks.node_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Resource = [
          module.messaging.queue_arn,
          module.messaging.dlq_arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:DeleteItem"
        ]
        Resource = module.dynamodb.table_arn
      }
    ]
  })
}
