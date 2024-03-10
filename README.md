# Automate Daily Operational Tasks for SRE

## ✔️ Required:
- Create the "critical" directory
```
mkdir /data/critical
```
- Install an SMTP server software such as Postfix or s-nail
- If you use Postfix , Configure Postfix to act as your SMTP server and the configuration file is usually located at **/etc/postfix/main.cf**
  - Start the Postfix service to make it operational:
    ```
    sudo systemctl start postfix
    ```
- If you use s-nail, Edit the s-nail configuration file located at **~/.mailrc**
  -  Reload the s-nail configuration to apply the changes:
     ```
     source ~/.mailrc
     ```
## ⭐ Results:
![Screenshot from 2024-03-10 21-28-32](https://github.com/amrabunemr98/Automate-Daily-Operational-Tasks-for-SRE/assets/128842547/f09e4a87-291b-4303-b696-c686fa1cd9db)

![Screenshot from 2024-03-10 21-30-00](https://github.com/amrabunemr98/Automate-Daily-Operational-Tasks-for-SRE/assets/128842547/268ca98f-3366-4e81-91cc-f7673cf0eb49)

![Screenshot from 2024-03-10 21-30-18](https://github.com/amrabunemr98/Automate-Daily-Operational-Tasks-for-SRE/assets/128842547/2aea9e53-a2ed-438f-b371-9668b4ba272c)
