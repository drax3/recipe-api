#!/bin/sh

set -e

# Install dependencies
apk add --update --no-cache postgresql-client && \
apk add --update --no-cache --virtual .tmp-build-deps \
  build-base postgresql-dev musl-dev

# Upgrade pip and install pipenv
pip install --upgrade pip pipenv

# Ensure pipenv uses the system Python
pipenv --python $(which python3)

# Lock dependencies
pipenv lock

# Install dependencies based on DEV flag
if [ "$DEV" = "true" ]; then
  pipenv install --dev --deploy --system
else
  pipenv install --deploy --system
fi

# Cleanup
rm -rf /tmp && \
apk del .tmp-build-deps && \
adduser --disabled-password --no-create-home django-user
