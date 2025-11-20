<img width="689" height="514" alt="Screenshot 2025-11-20 at 19 13 38" src="https://github.com/user-attachments/assets/a6313f3c-fd7b-48ac-a562-a7d1bca99f2e" /># Part 1: Environment Setup

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


# Part 3: Monitoring Script

- Created script `/usr/local/bin/system_report.sh`
- Gave executable permission:  
  `sudo chmod +x /usr/local/bin/system_report.sh`
- Tested the script manually:  
  `/usr/local/bin/system_report.sh`
- Opened cron editor:  
  `sudo crontab -e`
- Added cron job:  
  `*/5 * * * * /usr/local/bin/system_report.sh >> /var/log/system_report.log 2>&1`
- Viewed logs using:  
  `sudo tail -n 30 /var/log/system_report.log`

<img width="689" height="514" src="https://github.com/user-attachments/assets/287b8439-7a92-4118-9a33-1daa3f22cc3c" />


# Part 4: AWS Integration

- Installed AWS CLI using:  
  `curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`
- Unzipped:  
  `unzip awscliv2.zip`
- Installed AWS:  
  `sudo ./aws/install`
- Configured AWS CLI:  
  `aws configure`
- Created CloudWatch Log Group:  
  `aws logs create-log-group --log-group-name /devops/intern-metrics`
- Created Log Stream:  
  ```bash
  aws logs create-log-stream \
    --log-group-name /devops/intern-metrics \
    --log-stream-name system-report-stream

<img width="1416" height="864" alt="Screenshot 2025-11-20 at 19 20 41" src="https://github.com/user-attachments/assets/c5b75329-b0f8-4448-adc5-95d13d2c960b" />

<img width="1169" height="357" alt="Screenshot 2025-11-20 at 19 29 24" src="https://github.com/user-attachments/assets/c574c128-51e9-4de5-a3b1-3aec17b12893" />

# Bonus

<img width="954" height="201" alt="Screenshot 2025-11-20 at 19 34 53" src="https://github.com/user-attachments/assets/87ce3d77-0230-4d7b-9b9b-e9dc96be9adc" />


