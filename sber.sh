# 1. Удаляем все возможные запреты пароля
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 2. Если есть директория с доп. конфигами — проверяем и там
if [ -d /etc/ssh/sshd_config.d ]; then
    sudo grep -rl "PasswordAuthentication no" /etc/ssh/sshd_config.d/ | xargs sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/'
fi

# 3. Жёстко дописываем в конец файла (это имеет высший приоритет)
echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config

# 4. Перезапускаем SSH
sudo systemctl restart ssh

# 5. Проверяем, что сервер теперь предлагает пароль
sudo sshd -T | grep passwordauthentication