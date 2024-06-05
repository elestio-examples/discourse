#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 600s;

docker-compose exec -T postgresql bash -c "psql -U postgres postgres <<EOF
        \c bitnami_discourse
        UPDATE site_settings SET \"value\"='${SMTP_FROM_EMAIL}' WHERE \"name\"='notification_email';
EOF";