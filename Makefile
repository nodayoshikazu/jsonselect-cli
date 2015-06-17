PATH := ./node_modules/.bin:${PATH}

.PHONY : init clean-docs clean build test dist publish

init:
	npm install

docs:
	docco src/*.coffee

clean-docs:
	rm -rf docs/

clean: clean-docs
	rm -rf lib/ test/*.js

build:
	./node_modules/coffee-script/bin/coffee -o ./jsonselect-cli/ -c src/

test:
	node ./jsonselect-cli ":root" < test/sample1.json
	node ./jsonselect-cli ":root" -f test/sample1.json
	node ./jsonselect-cli ":root" -f test/sample1.json -o test/root-out.obj
	node ./jsonselect-cli ".languagesSpoken .lang" -f test/sample1.json
	node ./jsonselect-cli ".drinkPreference :first-child" -f test/sample1.json
	node ./jsonselect-cli ".seatingPreference :nth-child(1)" -f test/sample1.json
	node ./jsonselect-cli ".weight" -f test/sample1.json
	node ./jsonselect-cli ".lang" -f test/sample1.json
	node ./jsonselect-cli ".favoriteColor" -f test/sample1.json
	node ./jsonselect-cli "string.favoriteColor" -f test/sample1.json
	node ./jsonselect-cli "string:last-child" -f test/sample1.json
	node ./jsonselect-cli "string:nth-child(-n+2)" -f test/sample1.json
	node ./jsonselect-cli "string:nth-child(odd)" -f test/sample1.json
	node ./jsonselect-cli "string:nth-last-child(1)" -f test/sample1.json
	node ./jsonselect-cli ":root" -f test/sample1.json
	node ./jsonselect-cli "number" -f test/sample1.json
	node ./jsonselect-cli ":has(:root > .preferred)" -f test/sample1.json
	node ./jsonselect-cli ".preferred ~ .lang" -f test/sample1.json
	node ./jsonselect-cli ":has(.lang:val(\"Spanish\")) > .level" -f test/sample1.json
	node ./jsonselect-cli ".lang:val(\"Bulgarian\") ~ .level" -f test/sample1.json
	node ./jsonselect-cli ".weight:expr(x<180) ~ .name .first" -f test/sample1.json

dist: clean init docs build test

publish: dist
	npm publish
