# Use an official lightweight Python image as the base
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Set a DNS server (e.g., Google's public DNS)
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and the FastAPI application
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
