# Setup

## On Server

```
wg genkey > athena-wireguard
wg pubkey < athena-wireguard > athena-wireguard-public
```

this will generate the private and public keys to use in the VPṄ

The server is configured with a list of public keys belonging to each client, and each client is configured with the public key of the server.

## On Client

Thusly, for each client, you must do


```
wg genkey > clientname-wireguard
wg pubkey < clientname-wireguard > clientname-wireguard-public
```

and configure it to use `athena-wireguard-public` as the server public keẏ

`clientname-wireguard-public` is then added to the server config as a peer


