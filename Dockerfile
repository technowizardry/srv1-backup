FROM ubuntu:16.04

RUN /usr/bin/apt-get update \
   && /usr/bin/apt-get install --no-install-recommends -qy ruby ruby-dev make g++ zlib1g-dev patch cron openssh-client rsync mysql-client postgresql-client \
   && gem install backup --no-ri --no-rdoc \
   && /bin/rm -rf /var/lib/gems/2.3.0/cache /var/cache/* /var/lib/apt/lists/* \
   && apt-get purge -qy ruby-dev make g++ zlib1g-dev patch \
   && apt-get -qy autoremove \
   && backup generate:config
ADD models/ /root/Backup/models
ENTRYPOINT ["/usr/bin/ruby", "/usr/local/bin/backup"]
