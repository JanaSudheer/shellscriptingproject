# aws_resource_list

A small Bash script to list AWS resources for a given region and service.

## Overview

This repository contains a single script: `aws_service_list.sh`. The script queries AWS using the AWS CLI to list resources for commonly used services (EC2, RDS, S3, CloudFront, VPC, IAM, Route53, CloudWatch, CloudFormation, Lambda, SNS, SQS, DynamoDB, EBS).

> **Tip:** The script expects the AWS CLI to be installed and configured with credentials that have appropriate permissions.

---

## Features

* Simple command-line interface: `./aws_resourse_list.sh <region> <service>`
* Supports the following services:

  * `ec2` — describe instances
  * `rds` — describe DB instances
  * `s3` — list buckets
  * `cloudfront` — list distributions
  * `vpc` — describe VPCs
  * `iam` — list users
  * `route53` — list hosted zones
  * `cloudwatch` — describe alarms
  * `cloudformation` — describe stacks
  * `lambda` — list functions
  * `sns` — list topics
  * `sqs` — list queues
  * `dynamodb` — list tables
  * `ebs` — describe volumes

---

## Prerequisites

* Bash shell (Linux, macOS, WSL on Windows)
* [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured (`aws configure`) with credentials that have permissions to list the requested resources.
* (Optional) `jq` for prettier JSON filtering and formatting when piping outputs.

---

## Installation

1. Clone or copy the script to your local machine or server.
2. Make the script executable:

```bash
chmod +x aws_resourse_list.sh
```

3. Ensure AWS CLI is configured on the machine you run the script from:

```bash
aws configure
```

---

## Usage

```bash
./aws_resourse_list.sh <region> <service>
```

* `<region>` — AWS region (for example `us-east-1`, `ap-south-1`).
* `<service>` — one of the supported service keywords (see Features section).

### Examples

```bash
# List EC2 instances in us-east-1
./aws_resourse_list.sh us-east-1 ec2

# List RDS instances in ap-south-1
./aws_resourse_list.sh ap-south-1 rds

# List S3 buckets (note: S3 buckets are global resources)
./aws_resourse_list.sh us-east-1 s3
```

> **Note:** Some AWS services are global (for example `s3` list-buckets, `iam`, `route53`, and `cloudfront`). Passing a region for those services does not always change the output — AWS treats them as global resources.

---

## Script behavior & notes

* The script performs simple checks:

  * Validates that exactly two arguments are provided.
  * Verifies the `aws` CLI binary is available in `$PATH`.
  * Verifies that `aws sts get-caller-identity` succeeds (i.e., CLI is configured and credentials are valid).
* It then runs the corresponding AWS CLI command based on the `service` argument.
* The script exits with status `1` on incorrect usage or unsupported service, and `0` on success.

### Limitations & improvements

* The script currently prints raw AWS CLI output. Consider adding `--output json` or `--output table` flags explicitly, or pipe to `jq` for filtering and readable output.
* Pagination: some AWS CLI calls may return many pages. It’s recommended to pass `--no-paginate` or use `--page-size` flags where appropriate, or handle pagination programmatically.
* Error handling can be improved — the script assumes AWS CLI calls succeed after the initial `sts` check. Consider capturing command exit codes and printing helpful messages.
* Typo: filename `aws_resourse_list.sh` should be renamed to `aws_resource_list.sh` for clarity.
* Add `set -euo pipefail` and defensive coding to make the script safer in production.
* Add support for `--output` and `--profile` optional flags to allow switching profiles and formats easily.

---

## Example: Enhancements (suggested snippet)

Here is a short example snippet you could add to the script to pass `--output json` and accept an optional profile:

```bash
# usage helper inside the script
OUTPUT_FORMAT="json"
PROFILE_OPTION=""
if [ -n "${AWS_PROFILE:-}" ]; then
  PROFILE_OPTION="--profile $AWS_PROFILE"
fi

aws ec2 describe-instances --region "$REGION" --output "$OUTPUT_FORMAT" $PROFILE_OPTION
```

---

## Exit codes

* `0` — Success
* `1` — Incorrect usage, missing dependencies, unsupported service, or awscli not configured

---

## Contributing

If you'd like to contribute improvements, please:

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/your-change`.
3. Commit your changes and push the branch.
4. Open a pull request describing your change.

Suggested improvements: better error handling, support for additional services, parallel queries, or an interactive mode.

---

## Authors & License

* Author: sudheer / devops2515
* Original script date: 2024-06-15
* Version: v0.0.1


---

## Changelog

* `v0.0.1` — Initial script and README (2024-06-15)

--
