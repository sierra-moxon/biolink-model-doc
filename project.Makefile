## Add your own custom Makefile targets here

clean-docs:
	rm -rf docs/images/*
	rm -rf docs/types/*
	rm -rf docs/
	mkdir -p docs
	mkdir -p docs/images
	mkdir -p docs/types

gen-docs:
	poetry run gen-doc --directory target/docs --template-directory $(DOC_TEMP_DIR) $(SOURCE_SCHEMA_PATH)
	cp -pr target/docs/* docs/
	cp README.md docs/
	cp images/biolink-logo.png docs/
	cp -pr guidelines/* docs/

gen-oldschool:
	poetry run gen-yaml --generate $(SOURCE_SCHEMA_PATH) > biolink-model.yaml


gh-deploy:
# deploy documentation (note: requires documentation is in docs dir)
	poetry run mkdocs gh-deploy --remote-branch gh-pages --force
