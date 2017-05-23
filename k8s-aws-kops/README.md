# Instructions for Using this Demo Environment

## Prerequisites

This demo environment assumes that you have the following software installed, configured, and working properly:

* AWSCLI tools
* The `kops` utility (available from https://github.com/kubernetes/kops). Note that `kops` assumes the use of Route 53 from AWS, so you may also need to establish a DNS domain on Route 53 for `kops` to use.
* `kubectl` (available for Linux from https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl)

You'll also need `git` to clone this repository to your local system. Please ensure that you have all necessary prerequisites installed, configured, and working before attempting to use this demo environment.

This demo environment was tested on Fedora Linux, but it should work without any issues on any recent Linux distribution or on recent versions of OS X. I haven't tested this on Windows.

## Setup for the Demo Environment

1. Clone this repository to your local system using `git clone https://github.com/lowescott/2017-itx-container-workshop`.

2. Switch into the `k8s-aws-kops` subdirectory.

3. Set the `KOPS_STATE_STORE` environment variable to the URL of an existing S3 bucket, like `s3://kops.subdomain.domain.com` (where `subdomain.domain.com` is the Route 53 domain that `kops` is configured to use).

4. Create two EBS volumes, each with a size of 50GB, using these commands:

        aws ec2 create-volume --size 50 --availability-zone us-west-2a
        aws ec2 create-volume --size 50 --availability-zone us-west-2a

    Make note of the volume IDs for these volumes, as you'll need them in the next step. You can change the availability zone, if desired, but ensure that the availability zone specified here is also used later when establishing the Kubernetes cluster using `kops`.

5. Edit the `mysql.yml` file and change the line specifying the ID of the AWS EBS volume to match the ID of one of the volumes created in step 4.

6. Edit the `wordpress.yml` file and change the line specifying the ID of the AWS EBS volume to match the ID of the other volume created in step 4. _Make sure you don't specify the same volume ID in steps 5 and 6!_

You're now ready to create the demo environment.

## Creating the Demo Environment

Run the following command to create the Kubernetes cluster using `kops`:

    kops create cluster \
    --node-count 3 \
    --zones us-west-2a \
    --master-zones us-west-2a \
    --dns-zone subdomain.domain.com \
    --node-size t2.large \
    --master-size t2.large \
    --topology private \
    --networking flannel \
    --bastion \
    --ssh-public-key /path/to/ssh/keypair.pub \
    clustername.subdomain.domain.com

Replace `subdomain.domain.com` with the name of the Route 53 domain `kops` should use. If you used an availability zone other than "us-west-2a" when you created the EBS volumes earlier, make sure to specify the same availability zone in this command.

After a moment, `kops` will come back and ask you to run the same command with the `--yes` parameter. This will actually create the cluster.

This command will take several minutes to run. To verify the cluster is up and running once the command has completed, use `kubectl get nodes`.

The demo environment is now ready for use.

## Deploying the Demo Application

1. Once the cluster is up and running, create a Kubernetes secret for the MySQL password using this command:

        kubectl create secret generic mysql --from-literal=password=wpdatabase

2. Run `kubectl create -f mysql.yml` to deploy the MySQL container. Run `kubectl get deployments` and `kubectl get pods` to show the status.

3. Run `kubectl create -f mysql-service.yml` to create the MySQL service. Run `kubectl get svc` to show the service creation.

4. Run `kubectl create -f wordpress.yml` to create the WordPress container. As with step 2, you can run `kubectl get deployments` and `kubectl get pods` to show the status.

5. Run `kubectl create -f wordpress-service.yml` to deploy the WordPress service and associated load balancer. **This will take a few minutes.**

6. When the external IP is assigned to the load balancer (you can check using `kubectl get svc`), then open a web browser and navigate to that IP address to see WordPress running.

You have now deployed a containerized application to Kubernetes running on AWS.

## Cleaning up the Cluster

To leave the container cluster intact but remove the demo, use these steps:

1. Run `kubectl delete svc mysql` to remove the MySQL service.

2. Run `kubectl delete deployment mysql` to remove the MySQL deployment and associated pods.

3. Run `kubectl delete svc wordpress` to remove the WordPress service.

4. Run `kubectl delete deployment wordpress` to remove the WordPress deployment and associated pods.

5. Verify there are no deployments by running `kubectl get deployments`.

6. Verify there are no pods by running `kubectl get pods`.

Assuming the results of steps 5 and 6 are no objects returned, then the container cluster is ready to repeat the demo.

## Destroying the Entire Demo Environment

1. Run `kops delete cluster clustername.subdomain.domain.com --yes` to tear down the Kubernetes cluster and associated resources.

2. Use the AWS Console to remove any/all EBS volumes and any other resource not properly removed in step 1.
