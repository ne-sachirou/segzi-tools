build:
	node bin/build.js

test:
	node_modules/.bin/eslint .
	node_modules/.bin/mocha --recursive tests
	node_modules/.bin/textlint --rulesdir lib/rules README.md

# vim:set noet:
