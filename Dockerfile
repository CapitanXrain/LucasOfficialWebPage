FROM python:3.10.13

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt .
# install python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# running migrations
#RUN python manage.py makemigrations
#RUN python manage.py migrate
# Install netcat
RUN apt-get update && apt-get install -y netcat-traditional

#Esperar que este disponible la bd, realizar migraciones activar gunicorn
CMD ["sh", "-c", "while ! nc -z db 5432; do sleep 1; done; python manage.py migrate && gunicorn --config gunicorn-cfg.py core.wsgi"]

# gunicorn
#CMD ["gunicorn", "--config", "gunicorn-cfg.py", "core.wsgi"]
