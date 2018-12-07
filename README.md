# easyRSA

this is a configuration utility to work with a certificate authority

Based on `alpine:3.6` container. Using EasyRSA `2.2.2`

VOLUME

- `/ca`

# Build

```
docker build -t marvambass/easyrsa:latest .
```

# Usage

```
docker run --rm -ti -v $PWD:/ca marvambass/easyrsa:latest
```

## Start

to create a new CA just run

```
./build-ca
```

and answer the questions - it uses already our defaults

### create server cert

```
./build-key-server server.domain.tld
```

### create client cert without passphrase (recommended)

```
./build-key mmustermann
```

#### with passphrase

```
./build-key-pass mmustermann-pass
```

## revoke cert

```
./revoke-full mmustermann
```

### initialize revoke cert

do after ./build-ca

```
./build-key revokeimmediately
./revoke-full revokeimmediately
```

this creates a new client cert which is revoked immediately. now we can use it with openvpn
