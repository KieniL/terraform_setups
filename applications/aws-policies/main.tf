terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_organizations_policy" "requiretag" {
  name = "Project Tag Policy"

  type = "TAG_POLICY"

  content = <<CONTENT
{
    "tags": {
        "project": {
            "enforced_for": {
                "@@assign": [
                    "apigateway:apikeys",
                    "apigateway:domainnames",
                    "apigateway:restapis",
                    "apigateway:stages",
                    "appmesh:*",
                    "appconfig:application",
                    "appconfig:configurationprofile",
                    "appconfig:deployment",
                    "appconfig:deploymentstrategy",
                    "appconfig:environment",
                    "athena:*",
                    "auditmanager:assessment",
                    "auditmanager:assessmentControlSet",
                    "auditmanager:assessmentFramework",
                    "auditmanager:control",
                    "backup:backupPlan",
                    "backup:backupVault",
                    "batch:job",
                    "batch:job-definition",
                    "batch:job-queue",
                    "bugbust:event",
                    "acm:*",
                    "acm-pca:certificate-authority",
                    "chime:app-instance",
                    "chime:app-instance-user",
                    "chime:channel",
                    "cloud9:environment",
                    "cloudfront:*",
                    "cloudtrail:*",
                    "cloudwatch:*",
                    "events:*",
                    "logs:log-group",
                    "codebuild:*",
                    "codecommit:*",
                    "codeguru-reviewer:association",
                    "codepipeline:*",
                    "codestar-connections:connection",
                    "codestar-connections:host",
                    "cognito-identity:*",
                    "cognito-idp:*",
                    "comprehend:*",
                    "config:*",
                    "connect:contact-flow",
                    "connect:integration-association",
                    "connect:queue",
                    "connect:quick-connect",
                    "connect:routing-profile",
                    "connect:user",
                    "dlm:policy",
                    "directconnect:*",
                    "dms:*",
                    "dynamodb:*",
                    "ec2:capacity-reservation",
                    "ec2:client-vpn-endpoint",
                    "ec2:customer-gateway",
                    "ec2:dhcp-options",
                    "ec2:elastic-ip",
                    "ec2:fleet",
                    "ec2:fpga-image",
                    "ec2:host-reservation",
                    "ec2:image",
                    "ec2:instance",
                    "ec2:internet-gateway",
                    "ec2:launch-template",
                    "ec2:natgateway",
                    "ec2:network-acl",
                    "ec2:network-interface",
                    "ec2:reserved-instances",
                    "ec2:route-table",
                    "ec2:security-group",
                    "ec2:snapshot",
                    "ec2:spot-instance-request",
                    "ec2:subnet",
                    "ec2:traffic-mirror-filter",
                    "ec2:traffic-mirror-session",
                    "ec2:traffic-mirror-target",
                    "ec2:volume",
                    "ec2:vpc",
                    "ec2:vpc-endpoint",
                    "ec2:vpc-endpoint-service",
                    "ec2:vpc-peering-connection",
                    "ec2:vpn-connection",
                    "ec2:vpn-gateway",
                    "elasticfilesystem:*",
                    "elastic-inference:accelerator",
                    "eks:cluster",
                    "elasticbeanstalk:application",
                    "elasticbeanstalk:applicationversion",
                    "elasticbeanstalk:configurationtemplate",
                    "elasticbeanstalk:platform",
                    "ecr:repository",
                    "ecs:cluster",
                    "ecs:service",
                    "ecs:task-set",
                    "elasticache:cluster",
                    "es:domain",
                    "elasticloadbalancing:*",
                    "elasticmapreduce:cluster",
                    "elasticmapreduce:editor",
                    "firehose:*",
                    "frauddetector:detector",
                    "frauddetector:detector-version",
                    "frauddetector:model",
                    "frauddetector:rule",
                    "frauddetector:variable",
                    "fsx:*",
                    "globalaccelerator:accelerator",
                    "greengrass:bulkDeployment",
                    "greengrass:connectorDefinition",
                    "greengrass:coreDefinition",
                    "greengrass:deviceDefinition",
                    "greengrass:functionDefinition",
                    "greengrass:loggerDefinition",
                    "greengrass:resourceDefinition",
                    "greengrass:subscriptionDefinition",
                    "guardduty:detector",
                    "guardduty:filter",
                    "guardduty:ipset",
                    "guardduty:threatintelset",
                    "iam:instance-profile",
                    "iam:mfa",
                    "iam:oidc-provider",
                    "iam:policy",
                    "iam:saml-provider",
                    "iam:server-certificate",
                    "iotanalytics:*",
                    "iotevents:*",
                    "iotsitewise:asset",
                    "iotsitewise:asset-model",
                    "iotfleethub:application",
                    "kinesisanalytics:*",
                    "kms:*",
                    "lambda:*",
                    "macie2:custom-data-identifier",
                    "mediastore:container",
                    "mq:broker",
                    "mq:configuration",
                    "network-firewall:firewall",
                    "network-firewall:firewall-policy",
                    "network-firewall:stateful-rulegroup",
                    "network-firewall:stateless-rulegroup",
                    "organizations:account",
                    "organizations:ou",
                    "organizations:policy",
                    "organizations:root",
                    "rds:cluster-endpoint",
                    "rds:cluster-pg",
                    "rds:db-proxy",
                    "rds:db-proxy-endpoint",
                    "rds:es",
                    "rds:og",
                    "rds:pg",
                    "rds:ri",
                    "rds:secgrp",
                    "rds:subgrp",
                    "rds:target-group",
                    "redshift:*",
                    "ram:*",
                    "resource-groups:*",
                    "route53:hostedzone",
                    "route53resolver:*",
                    "s3:bucket",
                    "sagemaker:action",
                    "sagemaker:app-image-config",
                    "sagemaker:artifact",
                    "sagemaker:context",
                    "sagemaker:experiment",
                    "sagemaker:flow-definition",
                    "sagemaker:human-task-ui",
                    "sagemaker:model-package",
                    "sagemaker:model-package-group",
                    "sagemaker:pipeline",
                    "sagemaker:processing-job",
                    "sagemaker:project",
                    "sagemaker:training-job",
                    "secretsmanager:*",
                    "servicecatalog:application",
                    "servicecatalog:attributeGroup",
                    "servicecatalog:portfolio",
                    "servicecatalog:product",
                    "sns:topic",
                    "sqs:queue",
                    "ssm-contacts:contact",
                    "states:*",
                    "storagegateway:*",
                    "ssm:automation-execution",
                    "ssm:document",
                    "ssm:maintenancewindowtask",
                    "ssm:managed-instance",
                    "ssm:opsitem",
                    "ssm:patchbaseline",
                    "ssm:session",
                    "wellarchitected:workload",
                    "worklink:fleet",
                    "workspaces:*"
                ]
            }
        }
    }
}
CONTENT
  tags = {
    project = var.project
  }
}

resource "aws_organizations_policy_attachment" "tag" {
  policy_id = aws_organizations_policy.requiretag.id
  target_id = var.ou_id

}


resource "aws_organizations_policy" "allowedLocation" {
  name = "Allowed Location Policy"


  content = <<CONTENT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAllOutsideEU",
            "Effect": "Deny",
            "NotAction": [
                "a4b:*",
                "acm:*",
                "aws-marketplace-management:*",
                "aws-marketplace:*",
                "aws-portal:*",
                "budgets:*",
                "ce:*",
                "chime:*",
                "cloudfront:*",
                "config:*",
                "cur:*",
                "directconnect:*",
                "ec2:DescribeRegions",
                "ec2:DescribeTransitGateways",
                "ec2:DescribeVpnGateways",
                "fms:*",
                "globalaccelerator:*",
                "health:*",
                "iam:*",
                "importexport:*",
                "kms:*",
                "mobileanalytics:*",
                "networkmanager:*",
                "organizations:*",
                "pricing:*",
                "route53:*",
                "route53domains:*",
                "s3:GetAccountPublic*",
                "s3:ListAllMyBuckets",
                "s3:PutAccountPublic*",
                "shield:*",
                "sts:*",
                "support:*",
                "trustedadvisor:*",
                "waf-regional:*",
                "waf:*",
                "wafv2:*",
                "wellarchitected:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "eu-central-1",
                        "eu-west-1"
                    ]
                }
            }
        }
    ]
}
CONTENT
  tags = {
    project = var.project
  }
}

resource "aws_organizations_policy_attachment" "allowed_location" {
  policy_id = aws_organizations_policy.allowedLocation.id
  target_id = var.ou_id
}


resource "aws_organizations_policy" "allowedInstanceTypes" {
  name = "Allowed InstanceTypes Policy"


  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "RequireMicroInstanceType",
      "Effect": "Deny",
      "Action": "ec2:RunInstances",
      "Resource": [
        "arn:aws:ec2:*:*:instance/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "ec2:InstanceType": "t2.micro"
        }
      }
    }
  ]
}
CONTENT
  tags = {
    project = var.project
  }
}

resource "aws_organizations_policy_attachment" "allowedInstanceTypes" {
  policy_id = aws_organizations_policy.allowedInstanceTypes.id
  target_id = var.ou_id
}