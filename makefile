default:
	@cat makefile

view:test
init:
	python initialize_database.py

test:
	pytest -vvx db_viewer.py

clean:
	rm aquarium.db

clean_view: clean init view
