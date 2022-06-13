# Contributing

When contributing to this repository, please first discuss the change you wish
to make via issue, email, or any other method with the owners of this repository
before making a change.

Please note we have a code of conduct, please follow it in all your interactions
with the project.

## Required tooling

The only requirement is that you have Docker or some equivalent like Podman installed.

## Building a PDF release

* Prepare the base container image with `make prepare_image`. You will need to
  re-run this command every time a package is added to the style sheet or the
  image.
* Run `make build`

## Pull Request Process

1. Update the CHANGELOG.md a summary of the changes you've performed. This
   includes new packages, stylesheet sections, or changes to the contents.
2. Pull requests will be merged by maintainers after a successful review.
