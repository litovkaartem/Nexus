FROM python:3.11-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT ["./entrypoint.sh"]

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
