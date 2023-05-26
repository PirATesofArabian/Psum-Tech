# Psum-Tech
1. You need to setup your aws access key and token for using with terraform from the aws console.
2. Install the aws cli,terraform on your machine.
3. you need to run aws configure on the terminal that you are using , after that it will ask for the access key and token ,please enter it .. we are good to go.
4. Do terraform init,terraform plan and terraform apply to apply the infrastructure that you need to create, you can verify the same by going to the aws console.(Note: The AMI is region specific, so this particulat ami that i have used will work in ap-south-1 only)
5. For installing the docker, you can run commands like sudo apt install docker.io -y inside the ubunutu instance that we have created.
6. For deploying/starting the nginx container , we can run docker start -d -p 8080:80 nginx (this will download the nginx image from dockerhub and start the process on port 8080 on the host exposing 80 on container with detach mode, we can use the ipv4 address of host with port number to access the continer output)
7. For checking the healthcheck we can make use of the file dockerfile
8. For resource usage , we have a docker command called docker stats , with --no-stream the only the first time output will be displayed, so we can add that in a .sh file and either run a cronjob or we can also directly add it in systemd service where we define to run at specific intervals.
