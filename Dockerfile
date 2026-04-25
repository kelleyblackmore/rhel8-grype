FROM registry.access.redhat.com/ubi8:8.10

LABEL org.opencontainers.image.source="https://github.com/kelleyblackmore/rhel8-grype"
LABEL org.opencontainers.image.description="RHEL8 UBI container image with Grype vulnerability scanner and pre-populated database"
LABEL org.opencontainers.image.licenses="MIT"

# Install required packages
RUN dnf install -y curl tar && \
    dnf clean all

# Install grype
RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

# Pre-populate the grype vulnerability database
RUN grype db update

ENTRYPOINT ["grype"]
CMD ["--help"]
