symfony-6-sandbox Symfony application
============================

## Installing locally

1. Add `symfony-6-sandbox.local` to the `hosts` of your system
2. Copy `.env.dist` to `.env` and modify which `docker-compose.yml` files to use
3. Create an`app/.env.local` and modify accordingly
4. Run `docker-compose up -d`
5. Install Symfony `docker-compose exec -w /var/www php composer create-project symfony/skeleton:"6.4.*" html`
6. Re-Open `http://symfony-6-sandbox.local` and enjoy!

Optional : **Setup database**
 - Execute : `composer require symfony/orm-pack && composer require --dev symfony/maker-bundle`
 - Add this to your env.local : `DATABASE_URL="mysql://root:hello@symfony-6-sandbox-db-1:3306/app_db"`
 - You should be able to create new entity into our db: `bin/console make:entity` `bin/console make:migration` `bin/console doctrine:migration:migrate`

## Stopping

`docker-compose down`


## Xdebug

To enable:

1. Make sure `docker-compose.xdebug.yml` is included in the `COMPOSE_FILE` of your `.env`
2. Add server in PHPStorm named `xdebug` and map the `app/` directory to the `/var/www/html`
3. Use xdebug extension in the browser to start the session. To run a command with debugger 
   enabled, use the xdebug wrapper in the container, eg. `xdebug bin/console some:command`

To disable:

1. Make sure `docker-compose.xdebug.yml` is not included in your `.env`
