//go:build mage
package main

import (
	"github.com/magefile/mage/sh"
)

func Install() error {
	return sh.RunV("bash", "scripts/install_packages.sh")
}

func Build() error {
	return sh.RunV("bash", "scripts/build_app.sh")
}

func Run() error {
	return sh.RunV("bash", "scripts/run_app.sh")
}

func Lint() error {
	return sh.RunV("bash", "scripts/lint.sh")
}

func Clean() error {
	return sh.RunV("bash", "scripts/clean_cache.sh")
}

func Secret() error {
	return sh.RunV("bash", "scripts/generate_secret_key.sh")
}

func Hooks() error {
	return sh.RunV("bash", "scripts/setup_hooks.sh")
}

func Check() error {
	return sh.RunV("bash", "scripts/run_pre_commit.sh")
}
