# deploy-semaphore-on-ecs

## Architecture

This architecture uses AWS Fargate to deploy Semaphore and MySQL tasks in a highly available and scalable infrastructure. The infrastructure comprises the following elements:

- **Amazon ECS (Elastic Container Service)** : Container cluster management.
- **AWS Fargate**: Task execution without server management.
- **Amazon EBS (Elastic Block Store)**: Persistent storage for MySQL.
- **Amazon CloudWatch**: Performance and event monitoring and logging.
- **AWS Secrets Manager**: Secrets management for credentials.
- **AWS Cloud Map**: Discovery service for microservices applications.
- **VPC (Virtual Private Cloud)**: Isolation of resources in the network.
- **Auto Scaling Group**: Automatic scalability for Fargate tasks.

## Components

### Public Subnet

- **Internet Gateway**: Enables Internet access for resources in the public subnet.
-** Load Balancer**: Distributes incoming traffic to application instances.

### Private subnet

- **Auto Scaling Group**: Manages automatic scaling of Fargate instances.
- **Fargate MySQL task**: Container running MySQL with persistent storage on EBS.
- **Fargate Semaphore task**: Container running Semaphore for task orchestration and automation.

### Storage and Security

- **Amazon EBS**: Provides persistent storage mounted on the MySQL container.
- **AWS Secrets Manager**: Stores and manages MySQL database credentials.
- **CloudWatch Logs**: Collects and monitors Fargate job logs.


## Deployment

### Prerequisites

- An AWS account with the necessary permissions to create resources.
- Terraform installed on your machine.
- AWS CLI configured for your account.

### Deployment steps

1.  **Configure VPC and Subnets
    
    - Create a VPC with public and private subnets.
    - Configure an Internet gateway for the public subnet.
2.  **Deploy ECS cluster** Create an ECS cluster to manage the public subnet.
    
    - Create an ECS cluster to manage Fargate tasks.
    - Configure the necessary IAM roles to enable ECS to manage AWS resources.
3.  **Deploy Reargate Tasks**
    
    - Define task definitions for Semaphore and MySQL in ECS.
    - Ensure that the MySQL task uses Amazon EBS for persistent storage.
4.  **Configure Auto Scaling**
    
    - Configure auto-scaling policies for Fargate tasks to ensure high availability and resilience.
5.  **Configure Secrets Manager**
    
    - Store MySQL database credentials in AWS Secrets Manager.
    - Make sure that Fargate jobs can access these secrets.
6.  **Configure CloudWatch and Cloud Map**
    
    - Configure CloudWatch to monitor performance and capture logs.
    - Use Cloud Map for service discovery between Semaphore and MySQL.
7. This project uses Terraform to deploy the infrastructure

Initialize Terraform:
``terraform init``

Plan deployment:
``terraform plan``

Apply Configuration:
``terraform apply``

Check Deployment:

- Access AWS Management Console to check that all resources are created and functional.
- Use CloudWatch logs to monitor job status.
 - Application testing
Access the AWS EC2 console and navigate to Load Balancers under the Load Balancing menu.
Note the DNS Name of the Load Balancer.
Accessing the Application via the Browser
Open a web browser.
Enter the Load Balancer's DNS Name in the address bar. For example: http://my-load-balancer-1234567890.us-west-2.elb.amazonaws.com.
Your application interface should appear, confirming successful deployment.


## Monitoring and Management

- Use **CloudWatch** to monitor container and application performance.
- Use **AWS Secrets Manager** to manage credentials securely.
- Use **Cloud Map** for service discovery and microservices management.


## Restoring semaphore

This session is dedicated to restoring ansible semaphore.

1. Create key stores:
     - token: login type password to fill in the username and token to access the repository where there is our restore playbook
     - authentications: ssh type where we fill in the username and private key to connect to the ec2 instance
     - vault_key: login, password and vault key to decrypt the vault file containing our sensitive information

**![](https://lh7-us.googleusercontent.com/docsz/AD_4nXcoUwZrKWAtynD-n-Z30OBQxqHn-nwEmBZucVQ4K_UdeQGEVfm4Fk_51jljvtZ1pzE446hnDHwaOuRKtG2XBSpMPIFshOwMkQqoGVv1zmJbauKzc2_DMFs3Ah9d4CL2nUrdOa0Rz2feWaII5zpJ1AvkpLQx?key=L4XayPA1sB7Vrq7Z5fyZgg)**   
  
2. Create the inventory like this: 

**![](https://lh7-us.googleusercontent.com/docsz/AD_4nXc29J6juD1PfhcNKLyZluFEDwodbfFUU9SVrmddagrYTxBriImgX2VEsD12BG_TdeXHd8Tj88FHJWEvsacPE6zxibAnt8ZnPKn9xvau2wGl0eafbzWdbz6mRZhy437JYKcPZjfMOyGQ7IBuhNQm3wLJW-k?key=L4XayPA1sB7Vrq7Z5fyZgg)**

3. Enter the semaphore backup recovered from the s3 bucket (bd_semaphore folder) to be restored in the restore_semaphore.yml playbook.

**![](https://lh7-us.googleusercontent.com/docsz/AD_4nXdY16ugYBR7Thu4epgUCLT6dl0yxzlg_hZ3cMFRTs92UK-X-5MEuYECYjTHhYYCa0Vz3wtnkncTYlkPWEpC2nQOhh8JuduHl_iGQqnK8Lq2qn91lfD3knWNbgfidVdcR8Awz4bi31nBL2fuih3_losyDBO9?key=L4XayPA1sB7Vrq7Z5fyZgg)**

4. Create the repo:
     - Specify the link to the playbook repo, specifying the branch and token defined in the key store.
   
**![](https://lh7-us.googleusercontent.com/docsz/AD_4nXdE_a819hGtYPrgy3KJ1s7wRzZ23InnaEzOpsFfrzJyHUCLn5CLYpnJ84lSgIVTKIv_2G-NqVipz5AzlHJbRMmrYPmM-z5z_s65GFOcaaAozXPSuwISIy5SHVHJi8vpD1L-VHzoE3r7csBxm2sejcOjJ4sK?key=L4XayPA1sB7Vrq7Z5fyZgg)**
      
5. Create a task in task template named and fill in the following information:
    - playbook: - restore_semaphore.yml
    - inventory_localhost created earlier
    - repo: choose the previously created repository
    - vault key: choose the previously created vault key

**![](https://lh7-us.googleusercontent.com/docsz/AD_4nXexgbJmNTor4A5oEtzagD02lbNpvfVZIKmneJoWQNWMmEAky-7nHz4KfMXPNkR4T5bDVXt_BRyGlOx1AitE8sTZpY9ms9b-WeK5HIi9pdV0PpxI0OaxUmx44_vNvD7m00YfitFNUfDIoudqGc6CgYk5ZdE?key=L4XayPA1sB7Vrq7Z5fyZgg)**

then click on run:

**![](https://lh7-us.googleusercontent.com/docsz/AD_4nXfpNrKINOcYXF9m_xbD6BH9N3NLYY7V3Kyut8N80OFiv7dUSLdBVVsq3o-4YyAaGuZ9gqZc8kUhzlYX7ofI-eiOZKSPsiqFCoLbPN1q19iROinUG4RlbdJiP-iRFHlgy07Inqe53bYTJZWekHrcETcVkD8D?key=L4XayPA1sB7Vrq7Z5fyZgg)**
Reload the page and the restoration will be effective

## Conclusion

This project provides a scalable and secure solution for deploying container-based applications using AWS Fargate. It uses AWS services to ensure high availability, simplified secret management and efficient monitoring.
