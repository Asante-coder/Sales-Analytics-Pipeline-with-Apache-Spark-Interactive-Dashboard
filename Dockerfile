# Base image with Python
FROM python:3.11-slim

# Set environment variables for Spark
ENV SPARK_VERSION=3.5.1
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Apache Spark
RUN curl -L https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    | tar -xz -C /opt/ \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} $SPARK_HOME

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose Streamlit port
EXPOSE 8501

# Default command: run Streamlit dashboard
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]