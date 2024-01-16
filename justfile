default:
	just --list

run-backend:
	cd {{justfile_directory()}}/backend;\
	./gradlew bootrun

run-frontend:
	cd {{justfile_directory()}}/frontend/consumer;\
	flutter run -d chrome

sync:
	cd {{justfile_directory()}}/frontend/consumer;\
	flutter pub get
	cd {{justfile_directory()}}/backend;\
	./gradlew build
