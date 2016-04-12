NAME=tilmelding-bff
REPO=nathejk/$(NAME)

clean:
	rm -rf vendor

run:
	docker run -d -p 8003:80 --name $(NAME) -v `pwd`:/var/www -v /var/www/public/vendor -t $(REPO)

test:
	docker exec $(NAME) ./vendor/bin/phpunit ./src

build:
	docker build -t $(REPO) .

stop:
	docker rm -f $(NAME)

rerun: stop run
