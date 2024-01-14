# Task 7: How to setup an AWS Site-to-Site (S2S) VPN Connection
## <center>Architecture Diagram</center>
![no_image](https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/image46.png)

## Steps:

### 1. Select the VPN Connection and on top, click on the Download the configuration to download the config file which you need to add to the EC2 instance which you're using as Public Router in Mumbai Region.
- Vendor : Select Openswan

- Platform : Select Openswan

- Software : Leave default.

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/screenshot_263.png" alt="Image description">
</div>


### Now click on the Download button and the configuration file will be downloaded to your local machine and note down the file name. Once done click on the close or cancel button.Now Navigate to the Tunnel Details tab and you will be able to see that both tunnels are in down state, Next we are going to make the status as UP.

### 2. You need to SSH into the EC2 instance (On_Premises_Router) that you have created in the On_Premises_Network VPC that you have created in the Mumbai Region. This EC2 will act as the Public Router of On-Premises Network.

### 3. Please follow the steps in [SSH into EC2 Instance](https://www.whizlabs.com/labs/support-document/ssh-into-ec-instance).

### 4. Once you have successfully SSH in to EC2, run the following commands :
- Switch to root user :

        sudo -s

- Install Openswan

        yum install openswan -y

- Next make sure the last line in /etc/ipsec.conf is not commented. (NO # in the beginning)

        nano /etc/ipsec.conf

- Scroll to the end and make sure the last line include /etc/ipsec.d/*.conf has no hash (#) in the beginning.

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/image100.png" alt="Image description">
</div>

- Update /etc/sysctl.conf file

        nano /etc/sysctl.conf

- Add the below 3 lines in end of this file with no hash (#) in the beginning and add each in new lines

        net.ipv4.ip_forward = 1
        net.ipv4.conf.all.accept_redirects = 0
        net.ipv4.conf.all.send_redirects = 0
        
<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/image12.png" alt="Image description">
</div>

### 5. Restart Network Service

        service network restart

### 6. Next we need to configure IPSec and pre-shared keys in Openswan.

### 7. Next we need to configure IPSec and pre-shared keys in Openswan.

### 8. Create or open /etc/ipsec.d/aws.conf file

        vi /etc/ipsec.d/aws.conf
- In the Configuration file, look for point number 4  under IPSEC Tunnel #1 and copy the entire code below point number 4.

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/task_14_step_12.2.jpg" alt="Image description">
</div>

- Note: While pasting the code please remove white spaces at end of each line as well as replace the white spaces in the beginning of each line with tab space. If this is not followed the ipsec service won’t work

- Remove the line auth=esp from the file (else the connection won't work)

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/task_14_step_12.6.jpg" alt="Image description">
</div>

- Update leftsubnet and rightsubnet
- leftsubnet= Enter 10.0.0.0/16 (On-premises VPC CIDR) 
- rightsubnet= Enter 30.0.0.0/16 (AWS VPC CIDR)

### 9. Create or open /etc/ipsec.d/aws.secrets file

        vi /etc/ipsec.d/aws.secrets

- In the Configuration file, look for point number 5  under IPSEC Tunnel #1 and copy the entire code below.

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/task_14_step_13.2.jpg" alt="Image description">
</div>

### 10. Note : we will not be using IPSEC Tunnel #2 in this lab because Openswan only supports 1 tunnel. If you're using Cisco, Palo Alto, Fortinet Routes you will have an option to add the Tunnel 2. 

### 11. Switch to root user :

        sudo -s

### 12. Start IPSec service :

        systemctl start ipsec

### 13. Check the status of IPSec

        systemctl status ipsec

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/image53.png" alt="Image description">
</div>

### 14. Test the connectivity between two Networks

### 15. Ping the private EC2 from the Public EC2 Instance which acts as Public Router in Mumbai Region.

- Example : ping 30.0.1.31

<div style="text-align:center;">
        <img src="https://labresources.whizlabs.com/16b946592707a2ad9ff58e2c0491a2b5/image102.png" alt="Image description">
</div>