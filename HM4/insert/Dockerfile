FROM python:3.12.2

WORKDIR /app

COPY ./insert/requirements.txt .

RUN pip install -r requirements.txt

COPY ./insert .

CMD ["python","insert.py"]