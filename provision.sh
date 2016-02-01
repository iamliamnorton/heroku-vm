#!/bin/bash

sudo sh <<EOF
DEBIAN_FRONTEND=noninteractive \
  apt-get update && apt-get -y upgrade &&
  apt-get -y --force-yes --no-install-recommends install \
    ack-grep \
    build-essential \
    git-core \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    nodejs \
    postgresql \
    postgresql-client \
    postgresql-contrib \
    ruby-dev \
    vim

gem install bundler --no-ri --no-rdoc --version 1.11.2
bundle config --global build.nokogiri --use-system-libraries

dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

echo heroku-vm > /etc/hostname
EOF

ln -snf /vagrant/projects ~/projects

cat > ~/.bashrc <<'EOF'
export EDITOR=vim
EOF
