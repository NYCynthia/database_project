-- run the following commands individually starting in a bash shell

-- bash on mac $ psql postgres
-- bash on linux $ sudo -u postgres psql
CREATE DATABASE meetapp;
CREATE USER meetapp_user WITH PASSWORD 'password';
ALTER ROLE meetapp_user SET client_encoding TO 'utf8';
ALTER ROLE meetapp_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE meetapp_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE meetapp TO meetapp_user;
\q
