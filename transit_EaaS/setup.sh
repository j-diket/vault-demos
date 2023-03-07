#!/bin/bash
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root
vault secrets enable transit
vault write -f transit/keys/example
vault policy write transit-example -<<EOF
path "transit/encrypt/example" {
   capabilities = [ "update" ]
}
path "transit/decrypt/example" {
   capabilities = [ "update" ]
}
EOF
vault token create -policy=transit-example -id=example-token
export EXAMPLE_TOKEN=example-token
echo $EXAMPLE_TOKEN