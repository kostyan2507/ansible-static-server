# Базовый образ Ubuntu 24.04
FROM ubuntu:24.04

# Обновляем пакеты и устанавливаем openssh-server и sudo
RUN apt-get update && apt-get install -y openssh-server sudo

# Создаём директорию для SSH
RUN mkdir /var/run/sshd

# Устанавливаем пароль для root (временно, для тестов)
RUN echo 'root:root' | chpasswd
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Создаём пользователя ansible
RUN useradd -m -s /bin/bash ansible
RUN echo 'ansible:ansible' | chpasswd
RUN usermod -aG sudo ansible

# Открываем порт 22 для SSH
EXPOSE 22

# Запускаем SSH-сервер
CMD ["/usr/sbin/sshd", "-D"]
