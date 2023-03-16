# Transit Encryption Demo

>1. Download and install Vault OSS
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
    
    2. Start the Transit Secrets Engine on the default path.
    
    3. Create an encryption key ring for Transit keys on "example" path.

    4. Write an example policy for use with transit:
        `path "transit/encrypt/example" {
            capabilities = [ "update" ]
        }
        path "transit/decrypt/example" {
            capabilities = [ "update" ]
        }`
    This policy gives permission for keys to be updated on the path used for this example.
    
    5. Creates and exports a token with those policy permissions that will be used throughout the remainder of this example.

>4. In the bash terminal where you ran the setup script paste the below line of code.  Replace the "data to be encrypted" section (including <>) with any information you want encrypted, try a simple string.
>
>>`VAULT_TOKEN=$EXAMPLE_TOKEN vault write transit/encrypt/example plaintext=$(base64 <<< "<data to be encrypted>")`

This will return an output that includes the key "ciphertext" with an encrypted value.  The encrypted value begins with "vault:v1:" to denote that vault handled the encryption with version 1 of the encryption key, this allows Vault to know which key verion is needed when decrypting the data.

>5. Next paste in the below command and replace the ciphertext section with the outputed ciphertext from above:
>
>>`VAULT_TOKEN=$EXAMPLE_TOKEN vault write transit/decrypt/example ciphertext=<ciphertext>`

This will return a base64-encoded string that can be decoded using:
>`base64 --decode <<< "<encoded string>"`

You should now see the original string you entered into the encypt command.

## Rotating the encryption key

We can rotate the encryption key used during Transit encryption using simple CLI or API commands.  Within the API use:
>`vault write -f transit/keys/example/rotate`

Newly encrypted data will now have the "vault:v2:" prefix, showing the encryption used the new key.

We can enforce the key version needed to decrypt data:
>`vault write transit/keys/example/config min_decryption_version=2`

We can rewrap old encryption using the new key by leveraging the rewrap command:
>`vault write transit/rewrap/example ciphertext="vault:v1:cZNHVx+sxdMErXRSuDa1q/pz49fXTn1PScKfhf+PIZPvy8xKfkytpwKcbC0fF2U="`

Examine our key information:
>`vault read transit/keys/example`

Setup auto-rotation:
>`vault write transit/keys/example/config auto_rotate_period=5s`