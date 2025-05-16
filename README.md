1. Развертывание контейнера sonatype/nexus:
   docker run -d --name nexus -p 8081:8081 -v /opt/nexus-data:/nexus-data sonatype/nexus3
2. Создание Docker Hosted, Docker Proxy, Docker Group:
![image](https://github.com/user-attachments/assets/8ebf6671-5f03-414c-b509-d1f412487e3f)
![image](https://github.com/user-attachments/assets/fa169b0c-81aa-4c96-b75d-5ed856fb93dd)
![image](https://github.com/user-attachments/assets/c4c35fb7-ff05-4dab-80e8-9468b94949e8)
3. Привел /etc/docker/daemon.json к виду:
{
  "insecure-registries": ["192.168.20.174:8082", "192.168.20.174:8084"],
  "registry-mirrors": ["http://192.168.20.174:8084"]
}
И перезапустил docker.
4. Запустил веб-приложение https://gitfront.io/r/deusops/cgQdYMe4m1V1/django-girls-wo-docker/ на виртуальной машине app01.(Предварительно установил Python3.11, создал директорию db с файлом db.sqlite3).
5. Написал Dockerfile для приложения, предусмотрев в entrypoint.sh выполнение миграций и создание суперюзера admin:admin.
6. 
