FROM ruby:3.1-slim-bullseye as jekyll

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# used in the jekyll-server image, which is FROM this image
# COPY docker-entrypoint.sh /usr/local/bin/

RUN gem update --system && gem install jekyll && gem cleanup

WORKDIR /srv/jekyll

ADD Gemfile .

RUN bundle install --retry 5 --jobs 20

# ENTRYPOINT [ "jekyll" ]

# CMD [ "--help" ]

# FROM jekyll as jekyll-serve

# ENTRYPOINT [ "docker-entrypoint.sh" ]

# CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]
