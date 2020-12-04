FROM alpine:3.12.1 as build
ARG VERSION=v1.7.10
RUN apk --no-cache add curl \
 && curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64 \
 && chmod +x /usr/local/bin/argocd

FROM alpine:3.12.1
LABEL maintainer="ghilbut@gmail.com"
RUN rm /bin/ping \
       /bin/ping6 \
       /sbin/route \
       /usr/bin/wget
COPY --from=build /usr/local/bin/argocd /usr/local/bin/argocd
USER nobody
