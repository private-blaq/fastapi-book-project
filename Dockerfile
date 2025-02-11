# Use an official Python runtime as a parent image
FROM python:3.11

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install and configure Nginx
RUN apt update && apt install -y nginx && rm -rf /var/lib/apt/lists/*

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY app.conf /etc/nginx/sites-available/default

# Expose the necessary ports
EXPOSE 80

# Start Nginx and the application
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
