default:
	just --list

run-backend:
	cd {{justfile_directory()}}/backend;\
	./gradlew bootrun

run-management-frontend:
	cd {{justfile_directory()}}/frontend/management;\
	fvm flutter run -d chrome

run-customer-frontend:
	cd {{justfile_directory()}}/frontend/consumer;\
	fvm flutter run -d chrome

sync:
	cd {{justfile_directory()}}/frontend/consumer;\
	fvm flutter pub get
	cd {{justfile_directory()}}/frontend/management;\
	fvm flutter pub get
	cd {{justfile_directory()}}/backend;\
	./gradlew build
