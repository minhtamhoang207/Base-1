gen: ## Generates the assets
	@echo "╠ Generating code..."
	@fvm flutter pub get
	@fvm dart run build_runner build --delete-conflicting-outputs

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

run_dev_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app with development flavor"
	@fvm flutter run --flavor dev -t lib/main.dart --dart-define=flavor=dev