# wait-for-status

`wait-for-status` is a bash script that will wait for expected http_code (200 by default). It might be useful for synchronizing docker services.

## Usage

```
$ ./wait-for-status.sh -t 10 -s 200 localhost:8000 -- behave
```

inside docker-compose:

```
  tests:
      image: tests
      command: ["./wait-for-status.sh", "http://google.com", "--", "behave"]
```

## Info

This script is **strongly** inspired by [wait-for-it.sh](https://github.com/vishnubob/wait-for-it).
