# Use the official Python image as a base image
FROM python:3.9-slim

# Install system dependencies needed for building Python packages
RUN apt-get update && apt-get install -y gcc build-essential

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt requirements.txt

# Install the required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code into the container
COPY . .

# Expose the port the app runs on (if applicable, e.g., Flask default is 5000)
EXPOSE 5000

# Command to run your application (adjust if needed, e.g., flask run or python app.py)
CMD ["python", "server.py"]
