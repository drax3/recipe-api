FROM python:3.9-alpine3.13
LABEL maintainer="tusharkumar"

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1



# Install dependencies using pipenv
COPY Pipfile Pipfile.lock /code/
COPY install_deps.sh /install_deps.sh
RUN chmod +x /install_deps.sh

# copy the rest application
COPY ./code /code/
WORKDIR /code
EXPOSE 8000


# install system dependencies
ARG DEV=false
RUN DEV=$DEV /install_deps.sh

# add non-root user for security
USER django-user

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

