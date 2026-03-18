#!/bin/bash
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
if [ -d /etc/ssh/sshd_config.d ]; then
    sudo grep -rl "PasswordAuthentication no" /etc/ssh/sshd_config.d/ 2>/dev/null | xargs -r sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/'
fi
echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart ssh
sudo sshd -T | grep passwordauthentication
