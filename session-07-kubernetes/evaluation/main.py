from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import create_engine, text
import os

server = FastAPI(title='User API')

mysql_url = '127.0.0.1:3306'
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
        results = connection.execute(
            text('SELECT * FROM Users;')
        )

        rows = results.fetchall()

    return [
        User(
            user_id=i[0],
            username=i[1],
            email=i[2]
        )
        for i in rows
    ]


@server.get('/users/{user_id:int}', response_model=User)
async def get_user(user_id):
    with mysql_engine.connect() as connection:
        results = connection.execute(
            text('SELECT * FROM Users WHERE Users.id = :user_id'),
            {'user_id': user_id}
        )

        rows = results.fetchall()

    users = [
        User(
            user_id=i[0],
            username=i[1],
            email=i[2]
        )
        for i in rows
    ]

    if len(users) == 0:
        raise HTTPException(
            status_code=404,
            detail='Unknown User ID'
        )

    return users[0]
