# kiwi-farm
[![Build Status](https://travis-ci.org/Kiwi-Learn/kiwi-farm.svg?branch=master)](https://travis-ci.org/Kiwi-Learn/kiwi-farm)

A courses farm nourish to all kiwiers

# For development

After clone this repository, use `bundle` to install all dependences

```sh
$ bundle install
```

Use `rackup` to run the web app, and visit [http://localhost:9292](http://localhost:9292/)

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

# API using example

```js
GET /
```

```sh
# it will return the basic information of Kiwi farm
$ curl -GET http://127.0.0.1:9292/
Hello, This is Kiwi farm service. Current API version is v1. See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">Github repo</a>%
```
