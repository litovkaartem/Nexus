#!/bin/bash

pip install -r requirements.txt

python manage.py migrate blog

python manage.py migrate

echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | python manage.py shell

exec "$@"

