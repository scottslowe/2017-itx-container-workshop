# Instructions for Using this Demo Environment

## Prerequisites

This demo environment assumes that you have the AWSCLI tools installed and that they are working properly. You will also need a recent version of Git to clone the repository to your local system.

Before trying to use this demo environment, please ensure that you've installed the necessary prerequisites.

This demo environment was tested on Fedora Linux, but it should work without any issues on any Linux distribution or on recent versions of OS X. I don't know what would be required to make it work on Windows, sorry.

## Setup for the Demo Environment

1. Clone this repository down to your local system using `git clone https://github.com/lowescott/2017-itx-container-workshop`.

2. Switch into the `ecs` directory of the repository.

3. Edit `ecs-rds-template.json` to specify the name of a valid AWS keypair to use.

4. Edit `ssh.cfg` and change the "IdentityFile" line to match the keypair specified in the previous step (the two entries should match).

Please note that this environment is configured for the "us-west-2" AWS region. While it is possible to change this to a different region, multiple individual references to the region and associated availability zones would have to be made within `ecs-rds-template.json`.

## Creating the Demo Environment

1. From the `ecs` directory of the repository, run `aws cloudformation create-stack --stack-name ecs-demo --template-body file://ecs-rds-template.json`. This will create an RDS instance, a new ECS cluster with 3 instances, and all supporting infrastructure. **Please note this will take 5-10 minutes to complete, possibly longer.** You can use the AWS console to check on the status of the stack deployment.

2. Once the stack is fully deployed, use the AWS console to determine the endpoint for the RDS instance that was deployed. Edit `demo-task-def.json` to specify this endpoint as the value for `WORDPRESS_DB_HOST`.

## Deploying the Demo Application

1. Run `aws ecs register-task-definition --cli-input-json file://demo-task-def.json` to create the ECS task definition. You can use the AWS console to verify that the task definition was created.

2. Create a service by running `aws ecs create-service --cluster democluster --service wordpress --task-definition wp-demo:<x> --desired-count 3` (where `<x>` is the version of the task definition created in step 1, as indicated in the AWS console).

AWS will deploy the desired number of containers to satisfy the service definition. You can verify this using the AWS console.

## Cleaning up ECS Services and Task Definitions

If you want to leave the AWS infrastructure running but wish to clean up the services and task definitions, use these steps.

1. Run `aws ecs update-service --cluster democluster --service wordpress --desired-count 0` to "drain" the ECS cluster.

2. Run `aws ecs delete-service --cluster democluster --service wordpress` to remove the service.

3. Run `aws ecs deregister-task-definition --task-definition wp-demo:<x>` (where `<x>` is the version of the task definition you want ot remove). Repeat as needed to clear out all existing task definitions.

The ECS cluster and all supporting AWS infrastructure remain intact and ready for use.

## Destroying the Entire Demo Environment

From the `ecs` directory, just run `aws cloudformation delete-stack --stack-name ecs-demo` to tear down all the AWS infrastructure associated with this demo environment. You can use the AWS console to view progress and verify the removal of all resources. Note that on some occasions CloudFormation is unable to remove the ECS cluster. In this case, remove the ECS cluster manually, then delete the stack again. It should proceed normally.
