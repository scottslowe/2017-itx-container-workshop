# Instructions for Using this Demo Environment

## Prerequisites

Most of this demo environment can be done with only the Google Cloud Console, but I recommend also having `kubectl` installed (available for Linux from https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl). You'll also need `git` to clone this repository to your local system.

Please ensure that you have all necessary prerequisites installed, configured, and working before attempting to use this demo environment.

This demo environment was tested on Fedora Linux, but it should work without any issues on any recent Linux distribution or on recent versions of OS X. I haven't tested this on Windows.

## Creating the Demo Environment

1. Log into Google Cloud Console and navigate to the Container Engine area.

2. Create a Container Engine cluster of 3 nodes. The standard (default) settings are fine. You can also use the CLI by running `gcloud container clusters create cluster-1 --num-nodes=3`.

3. Follow the instructions to configure `kubetctl` to connect to this new cluster.

4. Create two persistent disks to be used by containers. This can be done using the web console. Be sure to name the disks "mysql-disk" and "wordpress-disk". If you have the `gcloud` CLI tool installed, you can use this command:

        gcloud compute disks create --size 100GB mysql-disk
        gcloud compute disks create --size 100GB wordpress-disk

    Ignore any messages about decreased performance.

The demo environment is now ready for use.

## Deploying the Demo Application

1. Once the cluster is up and running and you're able to connect using `kubectl`, create a Kubernetes secret for the MySQL password using this command:

        kubectl create secret generic mysql --from-literal=password=wpdatabase

2. Run `kubectl create -f mysql.yml` to deploy the MySQL container. Run `kubectl get deployments` and `kubectl get pods` to show the status.

3. Run `kubectl create -f mysql-service.yml` to create the MySQL service. Run `kubectl get svc` to show the service creation.

4. Run `kubectl create -f wordpress.yml` to create the WordPress container. As with step 2, you can run `kubectl get deployments` and `kubectl get pods` to show the status.

5. Run `kubectl create -f wordpress-service.yml` to deploy the WordPress service and associated load balancer. **This will take a few minutes.**

6. When the external IP is assigned to the load balancer (you can check using `kubectl get svc`), then open a web browser and navigate to that IP address to see WordPress running.

You have now deployed a containerized application to Google Container Engine.

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

Use the Google Cloud Console to delete the cluster, any instances, and any persistent disks created along the way.
