#!/bin/sh

set -e

apk add --no-cache gcc musl-dev libffi-dev openssl-dev python3-dev cargo
pip install --upgrade pip pipenv

pipenv lock

pipenv --python $(which python3)

if [ "$DEV" = "true" ]; then
  pipenv install --dev --deploy --system
else
  pipenv install --deploy --system
fi

adduser --disabled-password --no-create-home django-user