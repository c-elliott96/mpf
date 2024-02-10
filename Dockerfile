# ARG RUBY_VERSION=3.3.0
# FROM ruby:$RUBY_VERSION-slim
# ARG APP_HOME=/mpf
# RUN mkdir -p $APP_HOME
# WORKDIR ${APP_HOME}
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     curl \
#     git \
#     libssl-dev

# ARG APPUSER=mpf
# RUN addgroup --system --gid 1001 ruby && adduser --system --uid 1002 --ingroup ruby $APPUSER
# RUN chown $APPUSER:ruby ${APP_HOME}
# USER $APPUSER

# RUN gem install bundler --no-document -v 2.5.5
# COPY --chown=$APPUSER:ruby ./ ./
# RUN bundle install
# CMD ["bundle" "exec" "rspec" "spec"]

ARG RUBY_VERSION=3.0.6
FROM ruby:$RUBY_VERSION-slim
RUN mkdir -p /mpf
WORKDIR /mpf
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev

ARG APPUSER=mpf
RUN addgroup --system --gid 1001 ruby && adduser --system --uid 1002 --ingroup ruby $APPUSER
RUN chown $APPUSER:ruby .
USER $APPUSER

RUN gem install bundler --no-document -v 2.5.5
COPY --chown=$APPUSER:ruby ./ ./
RUN bundle install
CMD ["bundle" "exec" "rspec" "spec"]
