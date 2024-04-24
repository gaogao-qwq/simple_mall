set dotenv-load

backend_version := ```
	grep -Eo $'version = \'[A-Za-z0-9_.-]+\'' backend/build.gradle |
	egrep -Eo $'\'[A-Za-z0-9_.-]+\'' |
	sed $'s/\'//g'
```

default:
	just --list

sync:
	cd {{justfile_directory()}}/frontend/consumer;\
	fvm flutter pub get
	cd {{justfile_directory()}}/frontend/management;\
	fvm flutter pub get
	cd {{justfile_directory()}}/backend;\
	./gradlew build

deploy: deploy-customer-frontend deploy-management-frontend deploy-backend

build: build-backend build-customer-frontend build-management-frontend

run-backend:
	cd {{justfile_directory()}}/backend;\
	./gradlew bootrun

run-management-frontend:
	cd {{justfile_directory()}}/frontend/management;\
	fvm flutter run -d chrome

run-customer-frontend:
	cd {{justfile_directory()}}/frontend/consumer;\
	fvm flutter run -d chrome

build-backend:
	cd {{justfile_directory()}}/backend;\
	gradle bootJar

build-customer-frontend:
	cd {{justfile_directory()}}/frontend/consumer;\
	fvm flutter build web --release --dart-define=API_URI=$API_URI

build-management-frontend:
	cd {{justfile_directory()}}/frontend/management;\
	fvm flutter build web --release --dart-define=API_URI=$API_URI

deploy-customer-frontend:
	rsync -rvucP {{justfile_directory()}}/frontend/consumer/build/web/* $PRODUCTION_HOST:/var/www/simple_mall/customer

deploy-management-frontend:
	rsync -rvucP {{justfile_directory()}}/frontend/management/build/web/* $PRODUCTION_HOST:/var/www/simple_mall/management

deploy-backend:
	rsync -rvucP {{justfile_directory()}}/backend/build/libs/mall-{{backend_version}}.jar
