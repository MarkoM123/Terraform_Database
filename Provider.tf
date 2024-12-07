# AWS Terraform Infrastructure Setup

This project provisions a secure and scalable AWS infrastructure for hosting a database-driven web application using Terraform. Below is a detailed explanation of the components, their interactions, and functionality.

---

## **Infrastructure Overview**

### **Key Components**

1. **VPC and Networking**
   - **VPC**: Provides logical isolation for resources.
   - **Subnets**:
     - **Public Subnets**: Host resources requiring internet access (e.g., EC2 instance).
     - **Private Subnets**: Host internal resources like RDS (database) securely.
   - **NAT Gateway**: Enables private subnets to access the internet without being publicly accessible.
   - **Routing**:
     - Public subnets route internet traffic via the Internet Gateway.
     - Private subnets route internet traffic via the NAT Gateway.

2. **Security Groups**
   - **EC2 Security Group**:
     - Allows HTTP (port 80) and SSH (port 22) traffic from any IP.
     - Enables outgoing traffic to the RDS instance.
   - **RDS Security Group**:
     - Restricts PostgreSQL (port 5432) access to traffic from the EC2 security group.

3. **Database (RDS Instance)**
   - A **PostgreSQL database** is deployed in the private subnet.
   - Features:
     - **Multi-AZ Deployment** for high availability.
     - **Automated Backups** for data recovery.
   - Isolated from public internet access.

4. **Web Server (EC2 Instance)**
   - EC2 instance deployed in the public subnet to host the web application.
   - Configured via a startup script to:
     - Install Apache HTTP server.
     - Prepare SQL scripts to initialize the database.
     - Connect to the PostgreSQL database.

5. **Key Pair for SSH Access**
   - **RSA Key Pair** is generated:
     - The private key is saved locally for secure EC2 access.
     - The public key is registered with AWS for authentication.

---

## **Connections Between Components**

1. **EC2 to RDS**
   - The EC2 instance connects to the RDS database over **port 5432**.
   - Secured using specific security group rules.

2. **Public Internet to EC2**
   - Users can:
     - Access the web application via HTTP (port 80).
     - Manage the instance via SSH (port 22).

3. **Private Subnet Communication via NAT Gateway**
   - The RDS instance accesses the internet indirectly (e.g., for updates) through the NAT Gateway.

---

## **Functionality**

- **Database-Driven Web Application**:
  - The EC2 instance serves a web application that interacts with the RDS database.
  - User data is stored and retrieved securely from the database.

- **High Availability and Security**:
  - **Multi-AZ RDS** ensures database uptime during zone failures.
  - Private subnets and security groups enforce strict access control.

- **Scalability and Maintainability**:
  - Easily extend infrastructure with more instances, load balancers, or additional subnets.
  - Automated provisioning ensures reproducibility.

---

## **How Components Work Together**

1. **Users**: Access the web application hosted on the EC2 instance via HTTP (port 80).
2. **Web Server (EC2)**: Processes user requests and communicates with the PostgreSQL database.
3. **Database (RDS)**: Stores and retrieves application data securely in a private subnet.
4. **NAT Gateway**: Allows private resources to access the internet securely.
5. **SSH Access**: Admins manage the EC2 instance securely using the generated SSH key.

---

## **Getting Started**

### **Prerequisites**
- AWS CLI and Terraform installed locally.
- SSH client for EC2 instance management.

### **Steps to Deploy**
1. Clone this repository.
2. Configure your AWS credentials.
3. Customize variables in the `terraform.tfvars` file.
4. Run the following commands:
   ```bash
   terraform init
   terraform apply

