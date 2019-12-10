FROM ruby:2.6.3

ENV BUNDLER_VERSION=2.0.2 \
    TZ=/usr/share/zoneinfo/Asia/Tokyo

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /myapp
WORKDIR /myapp

RUN printf "install: --no-document\nupdate: --no-document\n" > /etc/gemrc && \
    gem install -N -v "$BUNDLER_VERSION" bundler

ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME" \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
