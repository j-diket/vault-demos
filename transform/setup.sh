#!/bin/bash
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root
vault secrets enable transform
vault write transform/role/payments transformations=card-number
vault write transform/transformations/fpe/card-number \
    template="builtin/creditcardnumber" \
    tweak_source=internal \
    allowed_roles=payments
# vault write transform/template/ccn \
#   type=regex \
#   pattern='(\d{4})[- ](\d{4})[- ](\d{4})[- ](\d{4})' \
#   encode_format='$1-$2-$3-$4' \
#   decode_formats=last-four='$4' \
#   alphabet=numerics
vault read transform/transformations/fpe/card-number