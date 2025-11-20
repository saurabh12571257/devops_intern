# Part 1: Environment Setup

- Launched an Ec2 t2.micro instance.
- SSH into it by running `chmod 400 "docker_prac.pem"` command in downloads folder and then  
  `ssh -i "docker_prac.pem" ubuntu@ec2-65-0-108-246.ap-south-1.compute.amazonaws.com`.
- Created a new USER using command: `sudo adduser devops_intern`
- Added the user into Sudo grp: `sudo usermod -aG sudo devops_intern`
- For giving passwordless sudo to devops_intern :  
  `sudo visudo` -> Inside it added line `devops_intern ALL=(ALL) NOPASSWD:ALL` at the bottom.
- Change the server’s hostname:  
  `sudo hostnamectl set-hostname saurabh-devops` ->  
  `sudo nano /etc/hosts` and replaced  
  `127.0.0.0   localhost` with `127.0.1.1   saurabh-devops`.

<img width="454" height="217" alt="Screenshot 2025-11-20 at 18 31 53" src="https://github.com/user-attachments/assets/7b9094c6-d72e-4362-8f75-fe7b990d53d7" />

<img width="778" height="749" alt="Screenshot 2025-11-20 at 18 34 01" src="https://github.com/user-attachments/assets/02400ddb-0038-4a7d-82ab-1f56f4bc8dac" />


# Part 2: Simple Web Service Setup

- `sudo apt install nginx -y` to install nginx
- For the html page I generated a token which I got to know about today :-  
  `TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")`
- Then fetched the instance id by :-  
  `INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)`
- In the script I used :  
  ```bash
  UPTIME=$(uptime -p)

  echo "<html>
  <head><title>DevOps Task</title></head>
  <body>
  <h1>Name: SAURABH DAVE</h1>
  <h2>Instance ID: $INSTANCE_ID</h2>
  <h2>Server Uptime: $UPTIME</h2>
  </body>
  </html>" | sudo tee /var/www/html/index.html > /dev/null

<img width="899" height="223" alt="Screenshot 2025-11-20 at 18 50 18" src="https://github.com/user-attachments/assets/87470227-96be-421b-9b0b-5437c3de8bd7" />


Part 3: Monitoring Script
