from psycopg2 import connect, Error
from contextlib import contextmanager
from random import randint

from faker import Faker

fake = Faker('uk-UA')

@contextmanager
def create_connection():
    """ create a database connection to a Postgres database """
    conn = None
    try:
        conn = connect(host='localhost', user='postgres', password='123456', database='postgres', port=5432)
        yield conn
        conn.commit()
    except Error as err:
        print(err)
        conn.rollback()
    finally:
        if conn:
            conn.close()


def create_table(conn, ex_sql):
    c = conn.cursor()
    c.execute(ex_sql)
    c.close()


if __name__ == '__main__':
    sql_ex = 'INSERT INTO users (name, email, password, age) VALUES (%s, %s, %s, %s)'

    with create_connection() as conn:
        c = conn.cursor()
        for _ in range(200):
            c.execute(sql_ex, (fake.name(), fake.email(), fake.password(), randint(18, 100)))
        c.close()
