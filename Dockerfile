# https://hub.docker.com/_/ruby
ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim
ARG APP_HOME
RUN mkdir -p ${APP_HOME}
WORKDIR $APP_HOME
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev

ARG APPUSER=mpf
# Below we use --home because in Debian Bookworm it will otherwise default to
# /nonexistent, which it refuses to create
RUN addgroup --system ruby && adduser --system --home /home/${APPUSER} --ingroup ruby $APPUSER
RUN chown $APPUSER:ruby .
USER $APPUSER

RUN gem install bundler --no-document -v 2.5.5
# Ensure Gemfile has not been modified since Gemfile.lock
RUN bundle config --global frozen 1
COPY --chown=$APPUSER:ruby ./ ./
RUN bundle install
CMD ["bundle", "exec", "rspec", "spec"]
