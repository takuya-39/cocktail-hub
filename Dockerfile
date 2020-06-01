FROM ruby:2.7.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
&&  npm install n -g \
&&  n stable \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    apt-transport-https \
    wget \
&&  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&&  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&&  apt-get update && apt-get install -y --no-install-recommends \
    yarn \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

RUN mkdir /cocktail-hub
ENV APP_ROOT /cocktail-hub
WORKDIR $APP_ROOT

COPY Gemfile /$APP_ROOT/Gemfile
COPY Gemfile.lock /$APP_ROOT/Gemfile.lock

RUN bundle install
COPY . $APP_ROOT
