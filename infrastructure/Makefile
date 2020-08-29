project_name = "sars-cov-2"
module_name = "ehrmantraut"
service_name = "$(project_name)-$(module_name)"

region = "eu-central-1"

admin_profile = "tortugas-administrator"
developer_profile = "tortugas-developer"

org_name = "tortugas"

wait_for_status_change=5

now := $(shell date +%s)

.PHONY: ehrmantraut-on-ec2-template-test
ehrmantraut-on-ec2-template-test:
	aws cloudformation validate-template --profile $(developer_profile) --region $(region) --template-body "file://./application-on-ec2.yaml" >> /dev/null

.PHONY: ehrmantraut-on-ec2
ehrmantraut-on-ec2:
	aws cloudformation deploy \
		--template-file "application-on-ec2.yaml" \
		--stack-name "$(project_name)-$(module_name)-on-ec2" \
		--region $(region) \
        --capabilities CAPABILITY_NAMED_IAM \
        --profile $(developer_profile) \
		--parameter-overrides ProjectName=$(project_name) ModuleName=$(module_name) VPCStackName="$(project_name)-vpc" DataLakeStackName="$(project_name)-datalake" Region="$(region)" ApplicationPort="5000"

.PHONY: update-ehrmantraut-on-ec2
update-ehrmantraut-on-ec2:
	aws cloudformation create-change-set \
		--change-set-name "$(project_name)-$(module_name)-on-ec2-${now}" \
		--change-set-type UPDATE \
		--template-body "file://./application-on-ec2.yaml" \
		--stack-name "$(project_name)-$(module_name)-on-ec2" \
		--region $(region) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(developer_profile) \
		--parameters ParameterKey=ProjectName,ParameterValue=$(project_name) ParameterKey=ModuleName,ParameterValue=$(module_name) ParameterKey=VPCStackName,ParameterValue="$(project_name)-vpc" ParameterKey=DataLakeStackName,ParameterValue="$(project_name)-datalake" ParameterKey=Region,ParameterValue="$(region)" ParameterKey=ApplicationPort,ParameterValue="5000"

	sleep $(wait_for_status_change)

	aws cloudformation execute-change-set \
		--change-set-name "$(project_name)-$(module_name)-on-ec2-${now}" \
		--stack-name "$(project_name)-$(module_name)-on-ec2" \
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
