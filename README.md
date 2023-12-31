_This project is just 4 fun_
To get the base version of this repo, just go to [Prject-Start-Point](https://github.com/FernandoZnga/django-my-first-app-4FUN/tree/Prject-Start-Point)

# Writing your first Django app

> _"Django was invented to meet fast-moving newsroom deadlines, while satisfying the tough requirements of experienced web developers."_

"_Writing your first Django app_" project can be found [here](https://docs.djangoproject.com/en/4.2/intro/tutorial01/)

This project includes a couple of low level extras, Django will be build on top of it. The intention is so you can have another option to build apps locally, fast and easy.

### Table of Content
1. [First: ToDo or Check](#first-todo-or-check)
2. [Folder Structure](#folder-structure)
3. [Now we can Start with Django Project using Docker](#now-we-can-start-with-django-project-using-docker)
4. [Let's work with the new Database]()

--------

## First: ToDo or Check

If you are using MacOS I usually recommend to have `brew` installed, this is a very handy tool where you can find almost anything.
You can go to to [Homebrew](https://brew.sh/index_es) and follow the steps.

Once you have it, remember to insert the Homebrew directory at the top of your PATH environment variables by adding the following line at the bottom of you `~./profile` file.
```bash
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
```

After that, installing Python is just:
```bash
$ brew install python
```

Check Python version, and you are ready.
```bash
# Check Python version
$ python --version
# or
$ python3 --version

# Output
Python 3.9.6

# Check Python package handler
$ pip --version
# or
$ pip3 --version
```

Let's check if you have Django:
```bash
# Check for Django version
$ python -m django --version
```
If you get back `No module named django`, follow this [How to install Django](https://docs.djangoproject.com/en/4.2/topics/install/).

If you don't want to install Django globally, no worries, we can do it later inside virtual environment.

Make sure you have Docker Composer already installed, if not, you can download it from [here](https://docs.docker.com/compose/install/).

## Folder Structure
Let's do a quick explanation about the baseline of files already cloned from GitHub.

```bash
makefiles
  >dabase.mk
  >server.mk
.env.sample
.gitignore
docker-compose.yml
Dockerfile
LICENCE
Makefile
README.md
requirements.txt
requirements-dev.txt
```

The folder `makefiles` contains commands to make the server and database to start, stop, build, migrate, etc. The commands can be found in te file `Makefile` in the root folder.

Before creating a project you need to clone/create a `.env` file, this will include all the environment variables you want to maintain secure and private, just like the variables in the sample file `.env.sample`.

the Docker file `docker-compose.yml` list all services we will work with in this project, for this in particular, we will need just two, the application server (using a Python image) and the database (using a Postgres image).
Notice that the Postgres credentials are requested here, those credential should be included in the just created environment file `.env`. Also notice that the web server will run in the Port:8000 and depends on another service, the database service.

Finally, we have the `requirements.txt` and `requirements-dev.txt`, as name suggest, the last one should only include those packages needed for development purposes, and those other packages needed for the application to fully run, should be included in the first one.
You can add all packages using a Python command:
```bash
pip freeze > requirements-dev.txt
```
This command will take a snapshot of the packages and their current version and logged into the file `requirements-dev.txt`. 

## [Now we can Start with Django Project using Docker]
First of all, let's start creating a virtual environment, this will encapsulate our application, for development it's really handy. Having a virtual environment will allow you to work on different projects, each project will have their own dependencies, packages and versions.
Let's run:
```bash
$ python -m venv env
$ source env/bin/activate
```
You'll se the word (env) in your command line.
Let's create our `.env` file and add our secret credentials
```bash
$ touch .env
$ vim .env
```

Press `i` to start insert, copy the content from `.env.sample` to `.env`, type your database name, database username and database password, press `ESC` then `:` and finally `wq` (write and quit).

One more thin before starting, let's install Django by typing:
```bash
$ pip install django
$ pip freeze > requirements.txt
```
Now we are ready to bring it up to life the server and database, let's run:
```bash
$ docker-compose run web django-admin startproject myapp .  ## myapp can be changed to your app
```
It will download the images, create the containers and install dependencies, basically Django & psycopg2, then creates the project.

After that, you'll se a bunch of new folders, try to start the app running this from the root folder (where Makefile is):
```bash
$ make start
```
You should see the server running on your [localhost](http://localhost:8000).

## Let's work with the new Database
Now that we have our server and database running in it own docker container, we need to add a Database user with the minimum permissions and the database where all objects will be stored.

Just run 
```bash
$ make db-connect
```
This command will pick the `PG_USERNAME` and `PG_DATABASE` to connect into the docker container. Once we are in we will run:
```bash
postgres=# CREATE DATABASE <myproject>; ## Output: CREATE DATABASE
postgres=# CREATE USER <myprojectuser> WITH PASSWORD '<password>'; ## Output CREATE ROLE
postgres=# ALTER ROLE <myprojectuser> SET client_encoding TO 'utf8'; ## Output ALTER ROLE
postgres=# ALTER ROLE <myprojectuser> SET default_transaction_isolation TO 'read committed'; ## Output ALTER ROLE
postgres=# ALTER ROLE <myprojectuser> SET timezone TO 'UTC'; ## Output ALTER ROLE
postgres=# GRANT ALL PRIVILEGES ON DATABASE <myproject> TO <myprojectuser>; ## Output GRANT
postgres=# GRANT ALL ON SCHEMA public TO <myprojectuser>; ## Output GRANT
postgres=# GRANT ALL ON SCHEMA public TO public; ## Output GRANT
postgres=# ALTER USER <myprojectuser> CREATEDB; ## Output ALTER ROLE
postgres=# \q ## Quit session
```

Now that we have our server running and our database user, we need to point it to use our brand-new Postgres database. Let's open the file `mysite.settings.py`

We need to import the credentials we already have in the `.env` file, to do so we need a Python package named `os`. Add in the import section of `settings.py` the following:
```bash
import os
...
```
Now we can import `.env` variables typing `os.environ.get('<variableNameHere>')`.
So `DATABASES` section could be like:
```bash
DATABASES = {
    'default': {
        'ENGINE': "django.db.backends.postgresql",
        'NAME': os.environ['DB_DATABASE'],
        'USER': os.environ['DB_USER'],
        'PASSWORD': os.environ['DB_PASSWORD'],
        'HOST': os.environ['DB_HOST'],
        'PORT': os.environ['DB_POST'],
        }
    }
```
Then you can `make stop`, `make start` and you'll have pointed out to Postgres docker container instead of SQLite3 (db by default). 

And that's it!

I really hope you enjoy this little tutorial to start Django using a Docker container.

Happy Coding!