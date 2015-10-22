# kiwi-farm
A courses farm nourish to all kiwiers

# For development

After clone this repository, use `bundle` to install all dependences

```sh
$ bundle install
```

Use `rackup` to run the web app, and visit http://localhost:9292/

```sh
$ rackup config.ru
Thin web server (v1.6.4 codename Gob Bluth)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
```

Run testing

```sh
$ rake spec
```
