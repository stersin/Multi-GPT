# Use an official Python base image from the Docker Hub
FROM python:3.11-slim

# Install git
RUN apt-get -y update
RUN apt-get -y install git chromium-driver

ARG UID=1000
ARG GID=1000

# Set environment variables
ENV PIP_NO_CACHE_DIR=yes \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Create a non-root user and set permissions
RUN groupadd -g $GID group$GID
RUN useradd -u $UID -g $GID --create-home appuser
WORKDIR /home/appuser
COPY requirements.txt /home/appuser/requirements.txt
USER appuser

RUN pip install --no-cache-dir --user -r requirements.txt

# Set the entrypoint
ENTRYPOINT ["python", "-m", "multigpt"]
