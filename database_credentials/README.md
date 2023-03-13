run docker_setup.sh from bash terminal

start vault dev server
>`vault server -dev -dev-root-token-id root`

in new bash terminal run vault_setup.sh

List current credentials in readonly role:
>`vault read database/creds/readonly`

Connect to database and list database users:
>`docker exec -i learn-postgres psql -U root -c "SELECT usename, valuntil FROM pg_user;"`