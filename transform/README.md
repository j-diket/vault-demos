# Transform Encryption Demo

>1. Download and install Vault
>
>>[Download link](https://developer.hashicorp.com/vault/downloads)

>2. Run the following line of code to start a local Vault server:
>
>>`vault server -dev -dev-root-token-id root`

This code starts a Vault server in dev mode, outputs default configuration, and lists the listening address, unseal key, and the root token which has been obfuscated with the `-dev-root-token-id` flag.

>3. In a bash terminal, navigate to the directory containing this file and run:
>
>>`sh ./setup.sh`

This seup script will do a few things:

    1. Export environment variables for the Vault API address and the Vault root token.
    
    2. Start the Transform Secrets Engine on the default path.
    
    3. Create a Transform role named "payments" and attach "card-number" transformation

    4. Create a transformation type names "card-number" that utilizes the built-in credit card number template.
    
    5. Output the details of created transformation for confirmation.

>4. Paste the following command in the bash terminal, changing the "value" to any number you'd like encoded *that matches the format*.
>>`vault write transform/encode/payments value=1111-2222-3333-4444`

>5. To decode the value, paste the following code, replacing the "value" with the output of Step 4.
>>`vault write transform/decode/payments \
        value=8492-9808-1939-2623`