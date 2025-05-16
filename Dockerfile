FROM python:3.10-slim

# Install system dependencies for dlib and other libraries
RUN apt-get update && apt-get install -y \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libpng-dev \
    libjpeg-dev \
    build-essential \
    libatlas-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Create and activate virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run the application
CMD ["gunicorn", "grad_porj.wsgi:application", "--bind", "0.0.0.0:$PORT"]