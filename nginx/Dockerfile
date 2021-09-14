#设置继承自定义sshd镜像
FROM sshd:dockerfile

#安装nginx，设置nginx以非daemon方式启动
RUN apt-get install -y nginx && rm -rf /var/lib/apt/lists/* && echo "\ndaemon off;" >> /etc/nginx/nginx.conf && chown -R www-data:www-data /var/lib/nginx

#注意这里要更改系统的时区设置，因为在Web应用中经常会用到时区这个系统变量，默认Ubuntu的设置会让你的应用程序发生不可思议的效果
RUN echo $TZ > /etc/timezone && apt-get update && apt-get install -y tzdata && rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

#添加用户的脚本，并设置权限，这会覆盖之前放在这个位置的脚本
ADD run.sh /run.sh
RUN chmod 755 /*.sh

#定义可以被挂载的目录，分别是虚拟主机的挂载目录、证书目录、配置目录和日志目录
VOLUME [ "/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx" ]

#定义工作目录
WORKDIR /etc/nginx

#定义输出命令
CMD ["/run.sh"]

#定义输出端口
EXPOSE 80
EXPOSE 443