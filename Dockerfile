# Multi-stage Dockerfile for Django Backend

# Stage 1: Build Stage
FROM python:3.11-slim AS builder

# Set the working directory
WORKDIR /app

# Copy requirements.txt first to cache dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Stage 2: Final Stage
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the installed dependencies from the builder stage
COPY --from=builder /app /app

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]