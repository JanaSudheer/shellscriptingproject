#!/bin/bash
# This script lists aws services in a specified region

########################################
#Script Information
#script to list aws services in a specified region
#This script requires awscli to be installed and configured with appropriate permissions.
#this script takes two arguments, region and service name
#This script will list the following services:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS


#Author: sudheer/devops2515
#Date: 2024-06-15
#Version="v0.0.1"
#Usage: ./aws_resourse_list.sh <region> <service>
#example: ./aws_resourse_list.sh us-east-1 ec2
########################################


#Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then 
    echo "usage: $0 <region> <service>"
    exit 1
fi

REGION=$1
SERVICE=$2

#check if awscli is installed
if ! command -v aws &> /dev/null; then
    echo "awscli is not installed. Please install awscli and configure it."
    exit 1
fi

#check if awscli is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "awscli is not configured. Please configure awscli with appropriate permissions."
    exit 1
fi

#List the services based on user input
case $SERVICE in
    ec2)
        aws ec2 describe-instances --region $REGION
        ;;
    rds)
        aws rds describe-db-instances --region $REGION
        ;;
    s3)
        aws s3api list-buckets --region $REGION
        ;;
    cloudfront)
        aws cloudfront list-distributions --region $REGION
        ;;                                                                                                              
    vpc)
        aws ec2 describe-vpcs --region $REGION
        ;;
    iam)
        aws iam list-users --region $REGION
        ;;
    route53)
        aws route53 list-hosted-zones --region $REGION
        ;;
    cloudwatch)
        aws cloudwatch describe-alarms --region $REGION
        ;;
    cloudformation)
        aws cloudformation describe-stacks --region $REGION
        ;;
    lambda)
        aws lambda list-functions --region $REGION              
        ;;
    sns)
        aws sns list-topics --region $REGION
        ;;  
    sqs)
        aws sqs list-queues --region $REGION
        ;;
    dynamodb)
        aws dynamodb list-tables --region $REGION
        ;;
    ebs)
        aws ec2 describe-volumes --region $REGION
        ;;
    *)
        echo "Unsupported service. Supported services are: ec2, rds, s3, cloudfront, vpc, iam, route53, cloudwatch, cloudformation, lambda, sns, sqs, dynamodb, ebs"
        exit 1
        ;;
esac        
exit 0  

