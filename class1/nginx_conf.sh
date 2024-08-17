# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user root;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
  use epoll;
  worker_connections 51200;
  multi_accept on;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;
    fastcgi_intercept_errors on;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    #请求大小 110MB
    client_max_body_size 110m;

    #开启压缩
    gzip on;
    gzip_min_length 5k;
    gzip_buffers 4 16k;
    gzip_http_version 1.1;
    gzip_comp_level 5;
    gzip_types application/x-javascript text/css text/javascript application/javascript application/json;
    gzip_disable "MSIE [1-6]\.";
    gzip_vary off;
    underscores_in_headers on;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/vhost/*.conf;


}


#######################################
root@da4ab80b213b:/etc/nginx/vhost# cat /etc/nginx/vhost/template.conf
upstream updateboot {
                server wpadmin:8090 max_fails=2 fail_timeout=30s weight=1;
#               server java-master:8082 max_fails=2 fail_timeout=30s weight=1;
#                server java-slave:8082 max_fails=2 fail_timeout=30s weight=1;
}
server {
        listen       80;
        server_name localhost ;

        access_log  /var/log/nginx/access.log;
        error_log /var/log/nginx/err.log ;
         location / {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location /editviewstage {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location /prodmanage {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location /admin {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location ~ /resource/assets/.*/view/.* {
            root /static;
           autoindex on;
        }
         location ~ /resource/assets/.*/manage/.* {
            root /static;
            autoindex on;
        }

         location ~ /resource/assets/.*/edit/.* {
            root /static;
            autoindex on;
        }
         location ~ /resource/pro/ {
            root /static;
            autoindex on;
        }
         location ~ /formdata/pro/ {
            root /static;
            autoindex on;
        }

        # 自定义 502 页面
        error_page 502 500 504 404 /50x.html;
        location = /50x.html {
            root   /etc/nginx;
        }

}
server{
        listen       443 ssl;
        server_name   localhost ;
        ssl_certificate /data/ssl/cms.pem;
        ssl_certificate_key /data/ssl/cms.key;
        ssl_session_timeout 5m;
        ssl_protocols SSLv2 SSLv3 TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
        ssl_prefer_server_ciphers on;
        access_log  /var/log/nginx/access.log;
        error_log /var/log/nginx/err.log ;
         location / {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location /editviewstage {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location /prodmanage {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location /admin {
                proxy_set_header Host $host:$server_port;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header REMOTE-HOST $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                client_max_body_size 1000m;
                proxy_pass http://updateboot;
        }
         location ~ /resource/assets/.*/view/.* {
            root /static;
           autoindex on;
        }
         location ~ /resource/assets/.*/manage/.* {
            root /static;
            autoindex on;
        }

         location ~ /resource/assets/.*/edit/.* {
            root /static;
            autoindex on;
        }
         location ~ /resource/pro/ {
            root /static;
            autoindex on;
        }
         location ~ /formdata/pro/ {
            root /static;
            autoindex on;
        }

        # 自定义 502 页面
        error_page 502 500 504 404 /50x.html;
        location = /50x.html {
            root   /etc/nginx;
        }


}


