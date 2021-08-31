#设置继承自定义的sshd镜像
FROM sshd:dockerfile

#设置环境变量，所有操作都是非交互式的
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai 

#安装
RUN apt-get -yq install apache2 && rm -rf /var/lib/apt/lists/*
#注意这里要更改系统的时区设置，因为在Web应用中经常会用到时区这个系统变量，默认Ubuntu的设置会让你的应用程序发生不可思议的效果
RUN echo $TZ > /etc/timezone && apt-get update && apt-get install -y tzdata && rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

#添加用户的脚本，并设置权限，这会覆盖之前放在这个位置的脚本
ADD run.sh /run.sh
RUN chmod 755 /*.sh

#添加一个示例的Web站点，删掉默认安装在apache文件夹下面的文件，并将用户添加的示例用软链接链到/var/www/html目录下面
RUN mkdir -p /var/lock/apache2 && mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
COPY sample/ /app

#设置apache相关的一些变量，在容器启动的时候可以使用-e参数代替
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]