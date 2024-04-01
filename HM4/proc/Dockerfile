FROM python:3.12.2

WORKDIR /app

COPY ./proc/requirements.txt .

RUN pip install -r requirements.txt

COPY ./proc .

CMD ["python","processing.py"]