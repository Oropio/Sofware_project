FROM python:3.6.5-stretch

ARG unbuffered
ARG uncached
ENV PATH /home/django/.local/bin:$PATH
ENV PYTHONUNBUFFERED=$unbuffered
ENV PYTHONDONTWRITEBYTECODE=$uncached

RUN groupadd -r django && useradd -r -m -g django django
USER django:django

WORKDIR /home/django/app
ADD requirements.txt /home/django/app/requirements.txt
RUN pip install --user -r requirements.txt

COPY --chown=django:django . /home/django/app
RUN DATABASE_URL=none DB_NAME=none DB_USER=none DB_PASS=none DB_SERVICE=none DB_PORT=none SECRET_KEY=none /usr/local/bin/python /home/django/app/manage.py collectstatic --noinput