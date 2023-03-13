#!/bin/bash
docker pull postgres:latest
docker run --detach --name learn-postgres -e POSTGRES_USER=root -e POSTGRES_PASSWORD=rootpassword -p 5432:5432 --rm postgres
docker ps -f name=learn-postgres --format "table {{.Names}}\t{{.Status}}
docker exec -i learn-postgres psql -U root -c "CREATE ROLE \"ro\" NOINHERIT;"
docker exec -i learn-postgres psql -U root -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"ro\";"