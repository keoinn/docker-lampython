# Docker Compose - Django Apache2 MySQL Dev Env.

### Document Structure
```sh
Folder
│  docker-compose.yml # Docker Compose YAML
├─compose # Service Application 
│  ├─app # Service Name
│  │      docker.apache.conf # Service Config
│  │      Dockerfile # Service Dockerfile
│  └─mysql
│         ...
└─src # Project Code
    ├─project # mount to /var/www/
    ├─data # MYSQL mount to /var/lib/mysql
    └─sql # database schema
        ...
```

### Build Envirment
```sh
# build and run as container
docker-compose up # Windows
docker compose up # Linux

# detached mode (background)
docker-compose up -d # Windows
docker compose up -d # Linux

# volume sync and detached (recommend)
docker-compose up -d -V # Windows
docker compose up -d -V # Linux
```

### Stop Container
```sh
docker-compose down
```

### Networking 
```sh
# index
127.0.0.1

# phpmyadmin
127.0.0.1:8080

# list ip address of each container
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```

### DNS Settins
#### Windows
add following code to `C:\Windows\System32\drivers\etc\hosts`
```sh
127.0.0.1 local.test
```

#### Mac
```sh
sudo echo "127.0.0.1 local.test" >> /private/etc/hosts
```

#### Linux
```sh
sudo echo "127.0.0.1 local.test" >> /etc/hosts
```

### .env file
```
mv env .env
```
- modify the `DJANGO_PROJECT_NAME` value which is yourself in .env file.

### command
```sh
docker exec -it lampython_app <COMMAND> <ARG>
docker exec -it lampython_app apachectl restart
```

### Commit Version Log
```
[2024-07-15] Apache2 + Python 3.12 + MySQL
```

### For Django
```python settings.py
import pymysql
pymysql.install_as_MySQLdb()
DATABASES = {
    # "default": {
    #     "ENGINE": "django.db.backends.sqlite3",
    #     "NAME": BASE_DIR / "db.sqlite3",
    # },
    "default": {
        "ENGINE": "django.db.backends.mysql",
        "NAME": "django",
        "USER": "root",
        "PASSWORD": "admin",
        "HOST": "mysql",
        "PORT": "3306",
        "OPTIONS": {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
        }
    }
}
```

```
asgiref==3.8.1
Django==5.0.7
Markdown==3.6
mysqlclient==2.2.4
sqlparse==0.5.0
PyMySQL==1.1.1
```
### Referance
* [Apache2 + PHP7.4 with FPM](https://blog.csdn.net/m0_55975991/article/details/124995718)
* [Docker LAMP with phpMyAdmin](https://hackmd.io/@titangene/docker-collection/%2FJo1wfBAaSzKx9anZ0WOv1Q?type=book)
* [Django Dockerizing](https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/#project-setup)
* [Django MySQL in Docker 1](https://stackoverflow.com/questions/76493897/when-i-wanna-dockerize-i-get-django-db-utils-operationalerror-2002-cant-c)
* [Django MySQL in Docker 2](https://stackoverflow.com/questions/76680452/i-am-getting-raise-improperlyconfigured-django-core-exceptions-improperlyconfig)


