COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	@mkdir *p /home/jait-ame/data/mariadb /home/jait-ame/data-wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

clean:
	docker system prune -f

fclean:
 sudo rm -rf /home/jait-ame/data/mariadb/* /home/jait-ame/data/wordpress/*


re: fclean all

.PHONY all up down stop clean fclean re
