# rhel8-grype

A container image based on **Red Hat UBI 8** (`registry.access.redhat.com/ubi8:8.10`) with [Grype](https://github.com/anchore/grype) (a vulnerability scanner for container images and filesystems) pre-installed along with its vulnerability database.

## Features

- Based on the official Red Hat Universal Base Image 8 (UBI8 8.10)
- Grype vulnerability scanner binary installed at `/usr/local/bin/grype`
- Grype vulnerability database pre-populated at build time
- GitHub Actions workflow for automated container builds
- Automatic tagging based on git refs (branches, tags, PRs)
- GitHub Container Registry (ghcr.io) integration

## Quick Start

Pull and run the image:

```bash
docker pull ghcr.io/kelleyblackmore/rhel8-grype:main
```

Scan a container image for vulnerabilities:

```bash
docker run --rm ghcr.io/kelleyblackmore/rhel8-grype:main <image-name>
# Example:
docker run --rm ghcr.io/kelleyblackmore/rhel8-grype:main alpine:latest
```

Scan a local directory (SBOM or filesystem):

```bash
docker run --rm -v $(pwd):/scan ghcr.io/kelleyblackmore/rhel8-grype:main dir:/scan
```

## Workflow Triggers

The workflow runs on:
- Push to `main` branch
- Tags matching `v*` pattern (e.g., `v1.0.0`)
- Pull requests to `main` branch (builds but does not push)
- Manual dispatch via GitHub Actions UI

## Image Tags

The workflow automatically generates the following tags:
- Branch name (e.g., `main`)
- Pull request number (e.g., `pr-123`)
- Semantic version from git tag (e.g., `1.0.0`, `1.0`)
- Git SHA (e.g., `sha-a1b2c3d`)

## Updating the Vulnerability Database

The database is baked into the image at build time. To refresh it, either rebuild the image or run `grype db update` inside a running container:

```bash
docker run --rm -it ghcr.io/kelleyblackmore/rhel8-grype:main db update
```

## License

MIT