rem init images, network and containers

docker image pull postgres:13.3
docker image pull dpage/pgadmin4:5.7
docker image pull postgrest/postgrest

docker network create --subnet=172.31.0.0/16 pg_test_network

docker run -d ^
	--net pg_test_network ^
	--ip 172.31.0.201 ^
	--name pg_test ^
	-p 5432:5432 ^
	-e POSTGRES_USER=test_user ^
	-e POSTGRES_PASSWORD=test_pwd ^
	-e POSTGRES_DB=default_test ^
	-v <tempCat>/pgdb:/var/lib/postgresql/data ^
	-v <testsCat>/testbd.sql:/docker-entrypoint-initdb.d/base.sql ^
	--health-cmd "pg_isready -U test_user -d default_test" ^
	--health-interval 10s ^
	--health-retries 5 ^
	--health-timeout 5s ^
	--health-start-period 10s ^
	--restart unless-stopped ^
	postgres:13.3 ^
	postgres -c shared_preload_libraries=pg_stat_statements -c pg_stat_statements.max=10000 -c pg_stat_statements.track=all
	
docker run -d ^
	--net pg_test_network ^
	--ip 172.31.0.202 ^
	--name pgadmin_test ^
	-p 5050:80 ^
	-e PGADMIN_DEFAULT_EMAIL=test_user@delimobil.ru ^
	-e PGADMIN_DEFAULT_PASSWORD=test_pwd ^
	-e PGADMIN_CONFIG_SERVER_MODE=False ^
	-v <tempCat>/pgadmin:/var/lib/pgadmin ^
	-v <testsCat>/pgadmin_servers.json:/pgadmin4/servers.json ^
	dpage/pgadmin4:5.7
	
docker run -d ^
	--net pg_test_network ^
	--ip 172.31.0.203 ^
	--name pgrest_test ^
	-p 3000:3000 ^
	-e PGRST_DB_URI=postgres://test_user:test_pwd@172.31.0.201:5432/test_db ^
	-e PGRST_DB_SCHEMA=public ^
	-e PGRST_DB_ANON_ROLE=test_user ^
	postgrest/postgrest