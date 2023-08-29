
### SERVER
# --------

server.install: ## Install dependencies on server
	docker-compose run --rm web pip install -r requirements-dev.txt

server.build: ## Rebuild the server
	docker-compose up --build

server.start: ## Start server in its docker container
	docker-compose up web

server.daemon: ## Start daemon server in its container
	docker-compose up -d web

server.stop: ## Stop the server on the container
	docker-compose stop

server.bash: ## Connect to server
	docker-compose exec web bash

server.shell: ## Start a python shell on the server
	docker-compose run web python manage.py shell

server.createsuperuser: ## Start a python shell on the server
	docker-compose run web python manage.py createsuperuser

server.tests: ## Start a python shell on the server
	docker-compose run web python manage.py test

docker.prune: ## Delete all docker containers and volumes
	docker system prune --all --volumes --force
