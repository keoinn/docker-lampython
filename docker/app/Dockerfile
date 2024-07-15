# pull official base image
FROM python:3.12.4-slim

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 安裝套件
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y apache2 \
    && apt-get install -y libapache2-mod-wsgi-py3 \
    && apt-get install -y mariadb-client \
    && apt-get install -y python3-dev \
    # && apt-get install -y default-libmysqlclient-dev \
    # && apt-get install -y libmysqlclient-dev \
    && apt-get install -y libmariadb-dev\
    && apt-get install -y build-essential \
    && apt-get install -y pkg-config 

RUN chmod 755 -R /var/log/apache2 \
    && chown www-data:www-data -R /var/log/apache2

# 虛擬環境
COPY --from=requirment_path ./requirements.txt .
RUN python -m venv /var/www/django_env

ENV PATH="/var/www/django_env/bin:$PATH"

RUN pip install --upgrade pip \
    pip install -r requirements.txt


# APACHE2 設定
COPY ./conf.d/local.test.conf /etc/apache2/sites-available/local.test.conf
RUN a2ensite local.test.conf 

WORKDIR /var/www/${DJANGO_PROJECT_NAME}

CMD ["apachectl", "-D", "FOREGROUND"]