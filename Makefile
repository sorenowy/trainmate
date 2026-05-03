# Makefile

.PHONY: install linter

# Setup:
setup:
	brew install swiftlint
	brew install swiftformat

fix:
	swiftlint --fix
	swiftformat .
