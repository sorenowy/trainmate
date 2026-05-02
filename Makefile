# Makefile

.PHONY: install linter :)

# Setup:
setup:
	brew install swiftlint

fix:
	swiftlint --fix
