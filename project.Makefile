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

gh-deploy:
# deploy documentation (note: requires documentation is in docs dir)
	poetry run mkdocs gh-deploy --remote-branch gh-pages --force

gen-py: gen-python gen-pydantic

gen-pydantic:
	rm -f src/biolink-model-doc/datamodel/pydanticmodel.py
	poetry run gen-pydantic $(SOURCE_SCHEMA_PATH) > src/biolink-model-doc/datamodel/pydanticmodel.py

gen-python:
	rm -f src/biolink-model-doc/datamodel/model.py
	poetry run gen-python $(SOURCE_SCHEMA_PATH) > src/biolink-model-doc/datamodel/model.py

	
