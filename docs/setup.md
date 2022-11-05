# URL Shortener

### Setup

#### Running on localhost
**1.1** Install Ruby version: 2.7.5 ([https://gorails.com/setup/macos/13-ventura](https://gorails.com/setup/macos/13-ventura))

**1.2** Install redis-server
https://flaviocopes.com/redis-installation/
```
redis-server /usr/local/etc/redis.conf
```
**1.3** Update variable value in .env
```
BASE_HOST=''
REDIS_URL='redis://localhost:6379/0'
```
**1.4** Install gems and setup database
```
bundle install
rails db:create
rails db:migrate
```
**1.4** Running server
```
bin/rails server
```

**1.4** Clean Expired Url
```
bin/rails urls:remove_expired_link
```

#### Running by Docker

```
docker-compose up

docker compose run website rails db:create
docker compose run website rails db:migrate
```
