default:
	just --list

run-backend:
	cd {{justfile_directory()}}/backend/;\
	./gradlew bootrun

run-frontend:
	cd {{justfile_directory()}}/frontend/consumer/;\
	flutter run -d chrome
