import os
from unittest.mock import MagicMock

# Variaveis de ambiente falsas exigidas pelo app.py na importacao (sem banco real disponivel no CI)
os.environ.setdefault("DATABASE_URL", "postgresql://fake:fake@localhost:5432/fake_db")
os.environ.setdefault("AUTH_SERVICE_URL", "http://fake-auth-service:8000")

# Evita que o app.py tente conectar de verdade no Postgres ao ser importado
import psycopg2.pool
psycopg2.pool.SimpleConnectionPool = MagicMock(return_value=MagicMock())
