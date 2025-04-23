FROM nginx

CMD ["nginx", "-g", "daemon off;"]

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/tailwindtoolbox/Landing-Page.git /home/Landing-Page

RUN cp /home/Landing-Page/index.html /usr/share/nginx/html/index.html

