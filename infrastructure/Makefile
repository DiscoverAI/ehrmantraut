project_name = "sars-cov-2"
service_name = "$(project_name)-ehrmantraut"

region = "eu-central-1"

admin_profile = "tortugas-administrator"
developer_profile = "tortugas-developer"

org_name = "tortugas"

wait_for_status_change=5

now := $(shell date +%s)

.PHONY: fargate-cluster-template-test
fargate-cluster-template-test:
	aws cloudformation validate-template --profile $(developer_profile) --region ${region} --template-body file://./fargate-cluster.yaml >> /dev/null

.PHONY: fargate-cluster
fargate-cluster:
	aws cloudformation deploy \
		--template-file fargate-cluster.yaml \
		--stack-name "$(project_name)-fargate-cluster" \
		--region $(region) \
        --capabilities CAPABILITY_NAMED_IAM \
        --profile $(developer_profile) \
		--parameter-overrides ProjectName=$(project_name) OrgName="$(org_name)" VPCStackName="$(project_name)-vpc"

.PHONY: update-fargate-cluster
update-fargate-cluster:
	aws cloudformation create-change-set \
		--change-set-name "$(project_name)-fargate-cluster-${now}" \
		--change-set-type UPDATE \
		--template-body file://./fargate-cluster.yaml \
		--stack-name "$(project_name)-fargate-cluster" \
		--region $(region) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(developer_profile) \
		--parameters ParameterKey=ProjectName,ParameterValue=$(project_name) ParameterKey=OrgName,ParameterValue=$(org_name) ParameterKey=VPCStackName,ParameterValue="$(project_name)-vpc"

	sleep $(wait_for_status_change)

	aws cloudformation execute-change-set \
		--change-set-name "$(project_name)-fargate-cluster-${now}" \
		--stack-name "$(project_name)-fargate-cluster" \
		--region $(region) \
		--profile $(developer_profile)


.PHONY: ehrmantraut-on-fargate-template-test
ehrmantraut-on-fargate-template-test:
	aws cloudformation validate-template --profile $(developer_profile) --region $(region) --template-body file://./ehrmantraut-on-fargate.yaml >> /dev/null

.PHONY: ehrmantraut-on-fargate
ehrmantraut-on-fargate:
	aws cloudformation deploy \
		--template-file ehrmantraut-on-fargate.yaml \
		--stack-name "$(project_name)-ehrmantraut-on-fargate" \
		--region $(region) \
        --capabilities CAPABILITY_NAMED_IAM \
        --profile $(developer_profile) \
		--parameter-overrides ProjectName=$(project_name) FargateClusterStackName="$(project_name)-fargate-cluster" VPCStackName="$(project_name)-vpc" DataLakeStackName="$(project_name)-datalake" ServiceName="ehrmantraut" ECRImageName="ehrmantraut" ContainerPort=5000

.PHONY: update-ehrmantraut-on-fargate
update-ehrmantraut-on-fargate:
	aws cloudformation create-change-set \
		--change-set-name "$(project_name)-ehrmantraut-on-fargate-${now}" \
		--change-set-type UPDATE \
		--template-body file://./ehrmantraut-on-fargate.yaml \
		--stack-name "$(project_name)-ehrmantraut-on-fargate" \
		--region $(region) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(developer_profile) \
		--parameters ParameterKey=ProjectName,ParameterValue=$(project_name) ParameterKey=FargateClusterStackName,ParameterValue="$(project_name)-fargate-cluster" ParameterKey=VPCStackName,ParameterValue="$(project_name)-vpc" ParameterKey=DataLakeStackName,ParameterValue="$(project_name)-datalake" ParameterKey=ServiceName,ParameterValue="ehrmantraut" ParameterKey=ECRImageName,ParameterValue="ehrmantraut" ParameterKey=ContainerPort,ParameterValue=5000

	sleep $(wait_for_status_change)

	aws cloudformation execute-change-set \
		--change-set-name "$(project_name)-ehrmantraut-on-fargate-${now}" \
		--stack-name "$(project_name)-ehrmantraut-on-fargate" \
		--region $(region) \
		--profile $(developer_profile)

.PHONY: ehrmantraut-on-ecr-template-test
ehrmantraut-on-ecr-template-test:
	aws cloudformation validate-template --template-body file://./ehrmantraut-on-ecr.yaml >> /dev/null

.PHONY: ehrmantraut-on-ecr
ehrmantraut-on-ecr:
	aws cloudformation deploy \
		--template-file ehrmantraut-on-ecr.yaml \
		--stack-name "$(project_name)-ehrmantraut-on-ecr" \
		--region $(region) \
        --capabilities CAPABILITY_NAMED_IAM \
        --profile $(developer_profile) \
		--parameter-overrides ProjectName=$(project_name)

.PHONY: update-ehrmantraut-on-ecr
update-ehrmantraut-on-ecr:
	aws cloudformation create-change-set \
		--change-set-name "$(project_name)-ehrmantraut-on-ecr-${now}" \
		--change-set-type UPDATE \
		--template-body file://./ehrmantraut-on-ecr.yaml \
		--stack-name "$(project_name)-ehrmantraut-on-ecr" \
		--region $(region) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(developer_profile) \
		--parameters ParameterKey=ProjectName,ParameterValue=$(project_name)

	sleep $(wait_for_status_change)

	aws cloudformation execute-change-set \
		--change-set-name "$(project_name)-ehrmantraut-on-ecr-${now}" \
		--stack-name "$(project_name)-ehrmantraut-on-ecr" \
		--region $(region) \
		--profile $(developer_profile)

.PHONY: ehrmantraut-on-ec2-template-test
ehrmantraut-on-ec2-template-test:
	aws cloudformation validate-template --profile $(developer_profile) --region $(region) --template-body file://./ehrmantraut-on-ec2.yaml >> /dev/null

.PHONY: ehrmantraut-on-ec2
ehrmantraut-on-ec2:
	aws cloudformation deploy \
		--template-file ehrmantraut-on-ec2.yaml \
		--stack-name "$(project_name)-ehrmantraut-on-ec2" \
		--region $(region) \
        --capabilities CAPABILITY_NAMED_IAM \
        --profile $(developer_profile) \
		--parameter-overrides ProjectName=$(project_name) VPCStackName="$(project_name)-vpc" DataLakeStackName="$(project_name)-datalake" Region="$(region)"

.PHONY: update-ehrmantraut-on-ec2
update-ehrmantraut-on-ec2:
	aws cloudformation create-change-set \
		--change-set-name "$(project_name)-ehrmantraut-on-ec2-${now}" \
		--change-set-type UPDATE \
		--template-body file://./ehrmantraut-on-ec2.yaml \
		--stack-name "$(project_name)-ehrmantraut-on-ec2" \
		--region $(region) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(developer_profile) \
		--parameters ParameterKey=ProjectName,ParameterValue=$(project_name) ParameterKey=VPCStackName,ParameterValue="$(project_name)-vpc" ParameterKey=DataLakeStackName,ParameterValue="$(project_name)-datalake" ParameterKey=Region,ParameterValue="$(region)"

	sleep $(wait_for_status_change)

	aws cloudformation execute-change-set \
		--change-set-name "$(project_name)-ehrmantraut-on-ec2-${now}" \
		--stack-name "$(project_name)-ehrmantraut-on-ec2" \
		--region $(region) \
		--profile $(developer_profile)

.PHONY: bastion-template-test
bastion-template-test:
	aws cloudformation validate-template --profile $(developer_profile) --region $(region) --template-body file://./bastion-host.yaml >> /dev/null

.PHONY: update-bastion
update-bastion:
	aws cloudformation create-change-set \
		--change-set-name "$(project_name)-bastion-${now}" \
		--change-set-type UPDATE \
		--template-body file://./bastion-host.yaml \
		--stack-name "$(project_name)-bastion" \
		--region $(region) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(developer_profile) \
		--parameters ParameterKey=ProjectName,ParameterValue=$(project_name) ParameterKey=VPCStackName,ParameterValue="$(project_name)-vpc" ParameterKey=Region,ParameterValue="$(region)"

	sleep $(wait_for_status_change)

	aws cloudformation execute-change-set \
		--change-set-name "$(project_name)-bastion-${now}" \
		--stack-name "$(project_name)-bastion" \
		--region $(region) \
		--profile $(developer_profile)

.PHONY: bastion
bastion:
	aws cloudformation deploy \
		--template-file bastion-host.yaml \
		--stack-name "$(project_name)-bastion" \
		--region $(region) \
        --capabilities CAPABILITY_NAMED_IAM \
        --profile $(developer_profile) \
		--parameter-overrides ProjectName=$(project_name) VPCStackName="$(project_name)-vpc" Region="$(region)"


.PHONY: infrastructure
infrastructure: ehrmantraut-on-ec2

.PHONY: template-test
template-test: ehrmantraut-on-ec2-template-test
