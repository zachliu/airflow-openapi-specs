.PHONY: check_version
check_version: ## Checks to see if TAG variable was passed in
	@if [ -z $(VERSION) ]; then \
		echo "VERSION not included in make statment."; \
		exit 1;\
	fi

.PHONY: generate
generate: check_version
	openapi-generator-cli generate \
		-i openapi.yaml \
		-g python \
		-o ../airflow-python-sdk/ \
		--package-name airflow_python_sdk \
		-p packageVersion=$(VERSION)

.PHONY: json2yaml
json2yaml:
	# https://github.com/mikefarah/yq
	yq eval -P api_v1_openapi.json > api_v1_openapi.yaml
