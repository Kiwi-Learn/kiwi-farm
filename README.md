# kiwi-farm
[![Build Status](https://travis-ci.org/Kiwi-Learn/kiwi-farm.svg?branch=master)](https://travis-ci.org/Kiwi-Learn/kiwi-farm)

A courses farm nourish to all kiwiers

# API using example

GET /
- returns OK status to indicate service is alive
- tells us the current API version and Github homepage of API
- example:
```sh
# it will return the basic information of Kiwi farm
$ curl -GET http://127.0.0.1:9292/
Hello, This is Kiwi farm service. Current API version is v1. See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">Github repo</a>
```


GET /api/v1/info/<course_id>.json
- returns JSON of a single course info: name, id, url, date
- example:
```sh
# it will return the info of a single course
$ curl -GET http://127.0.0.1:9292/api/v1/info/MA02004.json
{"id":"MA02004","name":"會計學原理","url":"http://www.sharecourse.net/sharecourse/course/view/courseInfo/352","date":"2015-10-12 - 2015-01-31"}
```


GET /api/v1/courselist
- returns JSON of all courses on ShareCourse
- example:
```sh
# it will return all courses on the Sharecourse
$ curl -GET http://127.0.0.1:9292/api/v1/courselist
[{"name":"行動磨課師【曠世名琴訴說的故事】","date":"2015-10-19 - 2015-12-06","url":"http://www.sharecourse.net/sharecourse/course/view/courseInfo/681","id":"AO35004"},
{"name":"方法對了，人人都可以是設計師","date":"2015-10-19 - 2015-12-06","url":"http://www.sharecourse.net/sharecourse/course/view/courseInfo/700","id":"DM91002"},
{"name":"英語課室的戲劇表演","date":"2015-10-19 - 2015-12-08","url":"http://www.sharecourse.net/sharecourse/course/view/courseInfo/679","id":"WL33002"},
...,
{"name":"小型風力機系統與國際認證 (104 秋季班)","date":"0000-00-00 - 0000-00-00","url":"http://www.sharecourse.net/sharecourse/course/view/courseInfo/711","id":"EE62002"}]
```


POST /api/v1/search
- takes JSON: keyword we want to search
- returns Json of the most keyword-matched course info: name, id ,url, date
- example:
```sh
# it will return the most keyword-matched course
$ url -H "Content-Type: application/json" -X POST -d '{"keyword":"program"}' http://127.0.0.1:9292/api/v1/search
{"id":"CS01007","name":"計算機程式設計 C Programming","url":"http://www.sharecourse.net/sharecourse/course/view/courseInfo/25","date":"2013-09-16 - 2014-02-14"}
```


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
