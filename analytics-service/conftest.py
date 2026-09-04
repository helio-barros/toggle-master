import os

# Variaveis de ambiente falsas exigidas pelo app.py na importacao
# (criar um client boto3 nao faz chamada de rede real, entao nao precisa mockar nada)
os.environ.setdefault("AWS_REGION", "us-east-2")
os.environ.setdefault("AWS_SQS_URL", "https://sqs.us-east-2.amazonaws.com/000000000000/fake-queue")
os.environ.setdefault("AWS_DYNAMODB_TABLE", "FakeTable")
