FROM python:3.10

# Debug message to confirm Dockerfile usage
RUN echo "Building with custom Dockerfile for grad_porj"

# Install system dependencies for dlib
RUN apt-get update && apt-get install -y \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libpng-dev \
    libjpeg-dev \
    build-essential \
    libatlas-base-dev \
    libblas-dev \
    libblas3 \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Create and activate virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Run the application
CMD ["gunicorn", "grad_porj.wsgi:application", "--bind", "0.0.0.0:$PORT"]