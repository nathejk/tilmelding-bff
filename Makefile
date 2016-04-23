NAME=tilmelding-bff
REPO=nathejk/$(NAME)
DOCKERHOST=172.17.42.1
PROXY_HOST=http://$(DOCKERHOST):8002

build:
	docker build -t $(REPO) .

clean:
	rm -rf vendor

run:
	docker run -d -p 8003:80 --name $(NAME) --env PROXY_HOST=$(PROXY_HOST) -v `pwd`:/var/www -v /var/www/public/vendor -t $(REPO)

test:
	docker exec $(NAME) ./vendor/bin/phpunit ./src

stop:
	docker rm -f $(NAME)

rerun: stop run

.PHONY: build clean run test stop rerun
