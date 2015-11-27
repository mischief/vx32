FROM busybox
MAINTAINER Nick Owens <mischief@offblast.org>

# 9vx will mkstemp in /var/tmp, which the busybox image lacks.
RUN install -d -m 1777 /var/tmp

COPY ./bin/9vx /bin/9vx

ENTRYPOINT ["/bin/9vx"]

