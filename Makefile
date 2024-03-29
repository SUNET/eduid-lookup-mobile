SOURCE=		eduid_lookup_mobile
EDUIDCOMMON=	../eduid-common/src
EDUIDUSERDB=	../eduid-userdb/src
PIPCOMPILE=	pip-compile --generate-hashes --extra-index-url https://pypi.sunet.se/simple

test:
	pytest --log-cli-level DEBUG

reformat:
	isort --line-width 120 --atomic --project eduid_lookup_mobile --recursive $(SOURCE)
	black --line-length 120 --target-version py37 --skip-string-normalization $(SOURCE)

typecheck:
	mypy --ignore-missing-imports $(SOURCE)

typecheck_extra:
	mypy --ignore-missing-imports $(EDUIDCOMMON) $(EDUIDUSERDB) $(SOURCE)

%ments.txt: %ments.in
	CUSTOM_COMPILE_COMMAND="make update_deps" $(PIPCOMPILE) $< > $@

update_deps: $(patsubst %ments.in,%ments.txt,$(wildcard *ments.in))
