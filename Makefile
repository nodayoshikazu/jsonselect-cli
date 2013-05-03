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
	./node_modules/coffee-script/bin/coffee -o lib/ -c src/

test:
	node lib/index.js ":root" < test/sample1.json
	node lib/index.js ":root" -f test/sample1.json
	node lib/index.js ":root" -f test/sample1.json -o test/root-out.obj
	node lib/index.js ".languagesSpoken .lang" -f test/sample1.json
	node lib/index.js ".drinkPreference :first-child" -f test/sample1.json
	node lib/index.js ".seatingPreference :nth-child(1)" -f test/sample1.json
	node lib/index.js ".weight" -f test/sample1.json
	node lib/index.js ".lang" -f test/sample1.json
	node lib/index.js ".favoriteColor" -f test/sample1.json
	node lib/index.js "string.favoriteColor" -f test/sample1.json
	node lib/index.js "string:last-child" -f test/sample1.json
	node lib/index.js "string:nth-child(-n+2)" -f test/sample1.json
	node lib/index.js "string:nth-child(odd)" -f test/sample1.json
	node lib/index.js "string:nth-last-child(1)" -f test/sample1.json
	node lib/index.js ":root" -f test/sample1.json
	node lib/index.js "number" -f test/sample1.json
	node lib/index.js ":has(:root > .preferred)" -f test/sample1.json
	node lib/index.js ".preferred ~ .lang" -f test/sample1.json
	node lib/index.js ":has(.lang:val(\"Spanish\")) > .level" -f test/sample1.json
	node lib/index.js ".lang:val(\"Bulgarian\") ~ .level" -f test/sample1.json
	node lib/index.js ".weight:expr(x<180) ~ .name .first" -f test/sample1.json

dist: clean init docs build test

publish: dist
	npm publish
