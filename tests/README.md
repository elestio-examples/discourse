<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Discourse, verified and packaged by Elestio

A better community platform for the modern web.

[discourse](https://www.bookstackapp.com/) is a discussion platform built for the next decade of the Internet.

<img src="https://github.com/elestio-examples/bookstack/raw/main/discourse.png" alt="discourse" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/discourse">fully managed discourse</a> on <a target="_blank" href="https://elest.io/">elest.io</a> to create a structured knowledge store for personal, team, or company use. BookStack focuses on ease-of-use and design to provide an experience suitable for an audience with, potentially, mixed skills in technology.

[![deploy](https://github.com/elestio-examples/bookstack/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/discourse)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/discourse.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:8080`

## Docker-compose

Here are some example snippets to help you get started creating a container.

        version: "3"

        volumes:
        db: {}

        services:
        db:
            image: mysql:8
            environment:
            MYSQL_DATABASE: bookstack-dev
            MYSQL_USER: bookstack-test
            MYSQL_PASSWORD: bookstack-test
            MYSQL_RANDOM_ROOT_PASSWORD: "true"
            command: --default-authentication-plugin=mysql_native_password
            volumes:
            - ./init.db:/docker-entrypoint-initdb.d
            - db:/var/lib/mysql
        app:
            # build:
            #   context: .
            #   dockerfile: ./Dockerfile
            image: elestio4test/bookstack:latest
            environment:
            APP_URL: http://localhost:${DEV_PORT:-8080}
            DB_CONNECTION: mysql
            DB_HOST: db
            DB_PORT: 3306
            DB_DATABASE: bookstack-dev
            DB_USERNAME: bookstack-test
            DB_PASSWORD: bookstack-test
            TEST_DATABASE_URL: mysql://bookstack-test:bookstack-test@db/bookstack-test
            MAIL_DRIVER: smtp
            MAIL_HOST: mailhog
            MAIL_PORT: 1025
            ports:
            - ${DEV_PORT:-8080}:80
            volumes:
            - ./:/app
            - ./php/conf.d/xdebug.ini:/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
            entrypoint: entrypoint.app.sh
            extra_hosts:
            - "host.docker.internal:host-gateway"
        node:
            image: node:alpine
            working_dir: /app
            user: node
            volumes:
            - ./:/app
            entrypoint: entrypoint.node.sh
        mailhog:
            image: mailhog/mailhog
            ports:
            - ${DEV_MAIL_PORT:-8025}:8025

### Environment variables

|       Variable       |    Value (example)     |
| :------------------: | :--------------------: |
|    ADMIN_PASSWORD    |        password        |
|     ADMIN_EMAIL      |    admin@admin.com     |
|    ADMIN_USERNAME    |         admin          |
| SOFTWARE_VERSION_TAG |         latest         |
|       APP_KEY        |     32 Char String     |
|       APP_ENV        |       production       |
|       APP_URL        |  https://example.com   |
|       DB_HOST        |       localhost        |
|     DB_DATABASE      |     database-name      |
|     DB_USERNAME      |   database-username    |
|     DB_PASSWORD      | database_user_password |
|     MAIL_DRIVER      |          smtp          |
|    MAIL_FROM_NAME    |         "name"         |
|      MAIL_FROM       | bookstack@example.com  |
|      MAIL_HOST       |       localhost        |
|      MAIL_PORT       |          587           |
|    MAIL_USERNAME     |          name          |
|    MAIL_PASSWORD     |       passsword        |
|   MAIL_ENCRYPTION    |          null          |

# Maintenance

## Logging

The Elestio Discourse Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://docs.discourse.org/">Discourse documentation</a>

- <a target="_blank" href="https://github.com/discourse/discourse_docker/">Discourse Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/discourse">Elestio/discourse Github repository</a>
