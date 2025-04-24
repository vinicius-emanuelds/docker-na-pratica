FROM nginx

CMD ["nginx", "-g", "daemon off;"]

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/creativetimofficial/material-kit.git /tmp/material-kit

RUN cp -r /tmp/material-kit/* /usr/share/nginx/html/
