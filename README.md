# PolyCTF

## Prerequisites

Install docker and docker-compose.

See :

- https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
- https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

## Launch the lab

```
docker-compose up --build
```

Note: It may take some time before the lab is ready.

The WordPress will be expose at: http://localhost:8000/

### Rules

You can look at the following files :

- docker-compose.yml
- Dockerfile

You should not look at these files :

- writeup.md
- secrets/\*
- entrypoint.sh

Have fun!

## Clean

```
docker-compose rm
```

