# spa-compiler
FROM  registry.access.redhat.com/ubi9/ubi-minimal:latest

# TODO: Put the maintainer name in the image metadata
# LABEL maintainer="Your Name <your@email.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

#LABEL io.k8s.description="Platform for building xyz" \
#      io.k8s.display-name="builder x.y.z" \
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,x.y.z,etc."

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
RUN microdnf -y module enable nodejs:20 && microdnf -y install nodejs tar

COPY ./s2i/bin/ /usr/libexec/s2i

RUN chown -R 1001:0 /usr/libexec/s2i && \ 
    chmod +x /usr/libexec/s2i/* && \
    mkdir /.npm && \
    chown -R 1001:0 "/.npm"


# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

RUN mkdir /app && chown -R 1001:0 /app

WORKDIR /app



# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# TODO: Set the default CMD for the image
# CMD ["/usr/libexec/s2i/usage"]
