# Ehrmantraut
> "You know, Walter, sometimes it doesn't hurt to have someone watching your back."
>
> -- Michael "Mike" Ehrmantraut (Breaking Bad)

Experiment tracking for computational drug design.

## Install
```bash
pipenv install
```

## Config
Configuration is done by environment variables. Pipenv supports .env file logic, so you could create a .env file
containing the environment variables and their values. Apart from that please make sure the environment variables are
set in some way.

Following environment variables are present:
```bash
DATALAKE=<s3 bucket path>
AWS_ACCESS_KEY_ID=<IAM user access key id that can read/write to the datalake>
AWS_SECRET_ACCESS_KEY=<IAM user secret access key that can read/write to the datalake>
```

## Run
```bash
pipenv run start
```

## Infrastructure
We've opted for the simplest setup for now: an EC2 instance deployed into a single private subnet with a Route53 record (`ehrmantraut.sars-cov-2.local`) pointing to the instance (which can be reached from anywhere on the VPC). This absolutely leaves room for improvement with scalability comes into play (e.g. ASGs, LBs, is Docker running?).
 
### Development
In the RARE case that you need to interact with the deployed AWS EC2 instance, you can either port forward the application to your machine (`./go run-ehrmantraut`) which would be reachable at `localhost:9999` or start an AWS Sessions Manager session (`./go start-session`) which drops you into a bash shell.
