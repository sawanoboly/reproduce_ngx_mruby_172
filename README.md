## reproduce_ngx_mruby

### Setup

```
$ git clone (This Repo)

$ cd (This Repo) 
$ git clone https://github.com/matsumoto-r/ngx_mruby.git
```

### Run

```
docker build -t reproduce_ngx_mruby . && docker run -p 8080:80 -it reproduce_ngx_mruby
```


### Check

```
# via proxy_pass (Success)
$ curl localhost
# or curl `docker-machine ip`:8080
# via fastcgi_pass (Failure)
$ curl localhost/index.php
# or curl `docker-machine ip`:8080/index.php
```

#### Log

- `/ngx_mruby/ngx_mruby/build_dynamic/nginx/logs/error.log` (debug)

Core and gdb

- `/tmp/core`

```
> gdb /ngx_mruby/ngx_mruby/build_dynamic/nginx/sbin/nginx /tmp/core
(gdb) backtrace full
```

