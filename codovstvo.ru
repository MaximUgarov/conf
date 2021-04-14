server {
        listen 80;

        server_name codovstvo.ru www.codovstvo.ru;
        return 301 https://$host$request_uri;
}
server {
        listen 443 ssl;

        ssl_certificate /home/siteadmin/settings/ssl/codovstvo/codovstvo.crt;
        ssl_certificate_key /home/siteadmin/settings/ssl/codovstvo/codovstvo.key;

 #       root /home/siteadmin/codovstvo;

#        index index.html index.htm index.nginx-debian.html;

        server_name codovstvo.ru www.codovstvo.ru;

        location / {
                proxy_pass http://127.0.0.1:9999/;
        }

        location ~ ^/helloapi/(.*)$ {
		proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
		proxy_pass       http://127.0.0.1:$1;
	}

       location /mainbot {
               proxy_redirect off;
               proxy_set_header Host $host;
               proxy_set_header X-Real-IP $remote_addr;
               proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto $scheme;
               proxy_read_timeout 3600;
               proxy_connect_timeout 1m;
               proxy_pass http://127.0.0.1:10055/;
       }

}

