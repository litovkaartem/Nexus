______Part I_____
1. Развертывание контейнера sonatype/nexus:
   docker run -d --name nexus -p 8081:8081 -v /opt/nexus-data:/nexus-data sonatype/nexus3
   
2. Создал Docker Hosted, Docker Proxy, Docker Group(docker hosted на 8082 порту http)

3. Привел /etc/docker/daemon.json к виду:
{
  "insecure-registries": ["192.168.20.139:5443"],
}
И перезапустил docker.

4. Запустил веб-приложение https://gitfront.io/r/deusops/cgQdYMe4m1V1/django-girls-wo-docker/ на виртуальной машине app01.(Предварительно установил Python3.11, создал директорию db с файлом db.sqlite3).
 
5. Написал Dockerfile для приложения, предусмотрев в entrypoint.sh выполнение миграций и создание суперюзера admin:admin.
 
6. При попытке логина и пуша образа в nexus docker hosted репу, столкнулся с некорректной работой nexus. Решил проблему с помощью HTTPS. Создал самоподписанные сертификаты с помощью mkcert, написал конфигурацию nginx(5443-8082) и обновил docker-compose.yml, добавив туда service nginx, который проксирует 8082 порт nexus(docker hosted http) через HTTPS. Файлы в папке NexusNginx.

7. Написал Vagrantfile для развертывания 2 ВМ в VirtualBox.

_____Part II_____
1. Клонировал репозиторий с приложением в проект GitLab. Написал простой пайплайн, поднял локальный Runner на docker executor.

2. Доработал пайплайн до 3 джоб: сборка, пуш в GitLab Registry, пуш в Nexus.

3. Добавил deploy job, осуществляющую пулл образа в app01 и запуск контейнера.
   
4. Рассмотрел варианты удаления образа из Nexus(Docker CLI, Curl, SSH)
