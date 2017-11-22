# Milestones

This follows [Semantic Versioning 2.0.0]

## 0.1
* Follow semantic versioning 2.0.0.
  *You are here.*

## 0.2
* End-to-end LFS book.

## 0.5
* Disable networking during build.
* Single-command update of happy path.
    - LFS book
    - `apt-offline`
        + This should be self-hosting.
        + Bootstrap `.deb`s should come from the `.zip`.
* Make `apt-offline` easy to pass down to sub-containers.
* Supports manual ZP install & run.
* `# REF: :LFS` tracking.
    - Catch relative links to files.

## 0.7
* Supports isolated ZP environment build.

## 0.8
* Absolute minimum dependencies needed to bootstrap.
    - Docker
    - git
    Transitive dependencies _do_ count. Update this list if necessary.

## 0.9
* Single-command build and launch of:
    - ZP
    - GCorp
    - GFS
    - Airflow
    - Development environment
        + VIM
        + tmux
* On:
    - OS X
    - Windows
    - Ubuntu LTS
    - Amazon Linux

## 1.0
* Formal spec of dependencies.
    - Licensing for all third-party code present in repo.
* Defined public API.
    - This is a must-have to comply with semver.
* Automated validation of semver? Sure would be nice!

## 1.1
* Support Buildkite build/test of:
    - ZP
    - GCorp
    - GFS
    - Airflow
* Tests for development environment.

## 2.0
* Self-hosting build of Docker.
