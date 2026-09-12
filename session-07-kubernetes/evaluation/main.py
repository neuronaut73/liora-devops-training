from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy.engine import create_engine
import os

server = FastAPI(title='User API')

mysql_url = 'localhost:3306'
mysql_user = 'root'
mysql_password = os.environ.get('MYSQL_PASSWORD')
database_name = 'Main'

connection_url = 'mysql://{user}:{password}@{url}/{database}'.format(
    user=mysql_user,
    password=mysql_password,
    url=mysql_url,
    database=database_name
)

mysql_engine = create_engine(connection_url)


class User(BaseModel):
    user_id: int = 0
    username: str = 'daniel'
    email: str = 'daniel@datascientest.com'


@server.get('/status')
async def get_status():
    return 1


@server.get('/users')
async def get_users():
    with mysql_engine.connect() as connection:
        results = connection.execute('SELECT * FROM Users;')

    results = [
        User(
            user_id=i[0],
            username=i[1],
            email=i[2]
        ) for i in results.fetchall()
    ]

    return results


@server.get('/users/{user_id:int}', response_model=User)
async def get_user(user_id):
    with mysql_engine.connect() as connection:
        results = connection.execute(
            'SELECT * FROM Users WHERE Users.id = {};'.format(user_id)
        )

    results = [
        User(
            user_id=i[0],
            username=i[1],
            email=i[2]
        ) for i in results.fetchall()
    ]

    if len(results) == 0:
        raise HTTPException(
            status_code=404,
            detail='Unknown User ID'
        )

    return results[0]
