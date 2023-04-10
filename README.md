## Purpose

Build a template repository to get to coding as quickly as possible, by starting from a common template which follows the guidelines [`here`](https://github.com/golang-standards/project-layout)

## Features
* Makefile to build consistently in a local environment and remote environment
* Dockerfile for a generic image to build for 
* Go Mod (which you should to your project path change)
* VS Code environment
* Generic docker push

## TODO
* Brew generic install [DONE]
* GITHUB Actions build and push to dockerhub [DONE]
* Production Builds with git tag

## Installing via brew
* `brew install --verbose --build-from-source brew/Formula/go-project-template.rb`
