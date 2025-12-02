FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Install system dependencies (minimal, SQLite already included in Python)
COPY requirements.txt /app/backend

RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/backend

# Expose Django port
EXPOSE 8000

# Run Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

