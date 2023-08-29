include .env
### DATABASE
# ----------

database.connect: ## Connect to database
	docker-compose exec db psql -h localhost -p 5432 -U ${PG_USER} -d ${PG_DATABASE}
# 	docker-compose exec db psql -Upostgres

database.makemigrations: ## Create alembic migration file
	docker-compose run --rm web python manage.py makemigrations

database.migrate: ## Upgrade to latest migration
	docker-compose run --rm web python manage.py migrate

database.local-connect: ## Connect to database
	docker-compose exec db psql -h localhost -p 5432 -U ${PG_USER} -d ${PG_DATABASE}
# 	docker-compose exec db psql -Upostgres

database.local-makemigrations: ## Create alembic migration file
	python manage.py makemigrations

database.local-migrate: ## Upgrade to latest migration
	python manage.py migrate

database.bash: ## Connect to terminal in the db server
	docker-compose exec db bash
