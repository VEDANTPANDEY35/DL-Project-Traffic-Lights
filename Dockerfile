FROM python:3.10

WORKDIR /app

# 🔥 Install dependencies first (cached layer)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# 🔥 Copy project files
COPY . .

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]