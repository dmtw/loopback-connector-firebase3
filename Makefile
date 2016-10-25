ENV = NODE_ENV=test DEBUG=
MOCHA = ./node_modules/.bin/_mocha
MOCHA_OPTS = -b --timeout 50000 --reporter spec
TESTS = test/*crud.test.js
ISTANBUL = ./node_modules/.bin/istanbul
COVERALLS = ./node_modules/.bin/coveralls

lint:
	@echo "Linting..."
	@./node_modules/.bin/jscs index.js lib test
test: lint
	@echo "Testing..."
	@$(ENV) $(MOCHA) $(MOCHA_OPTS) $(TESTS)
test-cov: lint
	@echo "Testing..."
	@$(ENV) $(ISTANBUL) cover $(MOCHA) -- $(MOCHA_OPTS) $(TESTS)
test-coveralls: test-cov
	@cat ./coverage/lcov.info | $(COVERALLS) --verbose
.PHONY: lint test test-cov test-coveralls