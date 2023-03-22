#set env vars
#set -o allexport; source .env; set +o allexport;

mkdir -p ./postgresql_data
mkdir -p ./redis_data
mkdir -p ./discourse_data
mkdir -p ./sidekiq_data

chmod 777 ./postgresql_data
chmod 777 ./redis_data
chmod 777 ./discourse_data
chmod 777 ./sidekiq_data