.DEFAULT_GOAL := help

### COMMANDS
# ----------

build || rebuild: server.build ## Rebuild service web

install: server.install ## Install dependencies on Docker container

start: server.start ## Starts the server on Docker container

stop: server.stop ## Stops the server on Docker container

start-daemon: server.daemon ## Starts the server in daemon

server-bash: server.bash ## Start a terminal from server

db-bash: database.bash ## Start a terminal from db server

server-shell: server.shell ## Starts the REPL from Python Docker container

db-connect: database.connect ## Connect to Postgres db on Docker container

db-migrations: database.makemigrations ## Create the migrations for latest changes

db-migrate: database.migrate ## Apply changes to database

docker-prune: docker.prune

include makefiles/server.mk
include makefiles/database.mk