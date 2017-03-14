#!/bin/bash -ex

sudo \
  BUNDLER_VER="1.14.6" \
  PHANTOM_JS="phantomjs-1.9.8-linux-x86_64" \
  RUBY_VER="2.3.3" \
  sh <<'EOF'
DEBIAN_FRONTEND=noninteractive \
apt-get update && apt-get -y upgrade &&
apt-get -y --force-yes --no-install-recommends install \
  ack-grep \
  build-essential \
  chrpath \
  git-core \
  libc-dev \
  libfreetype6-dev \
  libfontconfig1-dev \
  libssl-dev \
  libpq-dev \
  libxml2-dev \
  libxft-dev \
  libxslt1-dev \
  make \
  nodejs \
  postgresql \
  postgresql-client \
  postgresql-contrib \
  ruby \
  vim

git clone https://github.com/postmodern/ruby-install /usr/src/ruby-install
cd /usr/src/ruby-install
make install
ruby-install --system ruby ${RUBY_VER} -- --disable-install-rdoc
apt-get purge ruby
rm -rf /usr/src/*
rm -rf /var/lib/apt/lists/*

cd /tmp
wget https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOM_JS}.tar.bz2
tar xjf ${PHANTOM_JS}.tar.bz2
mv ${PHANTOM_JS} /usr/local/share
ln -sf /usr/local/share/${PHANTOM_JS}/bin/phantomjs /usr/local/bin

gem install bundler --no-ri --no-rdoc --version ${BUNDLER_VER}
bundle config --global build.nokogiri --use-system-libraries

dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

echo heroku-vm > /etc/hostname
EOF

ln -snf /vagrant/projects ~/projects

echo "Done."
echo ""
echo "Post install instructions:"
echo "sudo -u postgres psql postgres"
echo "\password postgres"

cat > ~/.bashrc <<'EOF'
export EDITOR=vim
EOF
