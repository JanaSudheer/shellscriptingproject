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