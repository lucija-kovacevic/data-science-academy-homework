FROM python:3.12.2

WORKDIR /app

COPY ./extr/requirements.txt .

RUN pip install -r requirements.txt

COPY ./extr .

CMD ["python","extracting.py"]