.DEFAULT_GOAL := help

### COMMANDS
# ----------

rebuild: server.rebuild ## Rebuild service web

install: server.install ## Install dependencies on Docker container

start: server.start ## Starts the server on Docker container

stop: server.stop ## Stops the server on Docker container

daemon: server.daemon ## Starts the server in daemon

bash: server.bash ## Start a terminal from server

shell: server.shell ## Starts the REPL from Python Docker container

connect: database.connect ## Connect to Postgres db on Docker container

migrations: database.makemigrations ## Create the migrations for latest changes

migrate: database.migrate ## Apply changes to database

docker-prune: docker.prune

include makefiles/server.mk
include makefiles/database.mk