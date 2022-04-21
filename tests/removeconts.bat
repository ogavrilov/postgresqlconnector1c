rem stop docker containers
docker stop pg_test
docker stop pgadmin_test
docker stop pgrest_test

rem remove docker containers
docker rm pg_test
docker rm pgadmin_test
docker rm pgrest_test

rem remove docker network
docker network rm pg_test_network

rem romove docker images
rem docker rmi postgres:13.3
rem docker rmi dpage/pgadmin4:5.7
rem docker rmi postgrest/postgrest
