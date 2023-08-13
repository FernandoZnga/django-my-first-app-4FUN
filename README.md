_This project is just 4 fun_
# Writing your first Django app

> _"Django was invented to meet fast-moving newsroom deadlines, while satisfying the tough requirements of experienced web developers."_

"_Writing your first Django app_" project can be found [here](https://docs.djangoproject.com/en/4.2/intro/tutorial01/)

This project includes a couple of low level extras, Django will be build on top of it. The intention is so you can have another option to build apps locally, fast and easy.

### Table of Content
## 1. [First: ToDo or Check]
## 2. [Folder Structure]
## 3. [Now we can Start with Django Project using Docker]

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
python freeze > requirements-dev.txt
```
This command will take a snapshot of the packages and their current version and logged into the file `requirements-dev.txt`. 

## [Now we can Start with Django Project using Docker]
First of all, let's start creating a virtual environment, this will encapsulate our application, for development it's really handy. Having a virtual environment will allow you to work on different projects, each project will have their own dependencies, packages and versions.
Let's run:

