# Go parameters
BINARY_NAME=go-project-template
BINARY_UNIX=$(BINARY_NAME)_unix
REPO=docker.pkg.github.com/dathan/go-project-template/go-project-template

.PHONY: all
all: lint test build

.PHONY: lint
lint:
				golangci-lint run ./...

.PHONY: build
build:
				go build -o ./bin ./cmd/...

.PHONY: test
test:
				go test -p 6 -covermode=count -coverprofile=test/coverage.out test/*.go

.PHONY: clean
clean:
				go clean
				find . -type d -name '.tmp_*' -prune -exec rm -rvf {} \;

.PHONY: run
run:
				go run ./cmd/$(BINARY_NAME)/*.go

.PHONY: vendor
vendor:
				go mod vendor

# Cross compilation
.PHONY: build-linux
build-linux:
				CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/$(BINARY_UNIX) -v cmd/$(BINARY_NAME)/

# Build docker containers
.PHONY: docker-build
docker-build:
				# docker build  \
				#	--build-arg GITHUB_SSH_PRIV_KEY="`cat ~/.ssh/id_rsa`" \
				#	-t $(or ${dockerImage},$(BINARY_NAME)-release) .
				docker build \
					-t $(or ${dockerImage},$(BINARY_NAME)-release) .

.PHONY: docker-tag
docker-tag:
			docker tag `docker image ls --filter 'reference=$(BINARY_NAME)-release' -q` $(REPO):`git rev-parse HEAD`

# Push the container
.PHONY: docker-push
docker-push: docker-build docker-tag
				docker push $(REPO):`git rev-parse HEAD`


.PHONY: docker-clean
docker-clean:
				docker rmi `docker image ls --filter 'reference=$(BINARY_NAME)-*' -q`
