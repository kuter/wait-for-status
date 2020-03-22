# wait-for-status

`wait-for-status` is a bash script that will wait for expected http_code (200 by default). It might be useful for synchronizing docker services.

## Usage

```
$ ./wait-own.sh -t 10 -s 200 localhost:8000 -- behave
```

## Info

That script is inspired by [wait-for-it.sh](https://github.com/vishnubob/wait-for-it)
