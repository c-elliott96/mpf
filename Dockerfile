ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim
ARG APP_HOME
RUN mkdir -p ${APP_HOME}
WORKDIR /mpf
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev

ARG APPUSER=mpf
RUN addgroup --system ruby && adduser --system --ingroup ruby $APPUSER
RUN chown $APPUSER:ruby .
USER $APPUSER

RUN gem install bundler --no-document -v 2.5.5
COPY --chown=$APPUSER:ruby ./ ./
RUN bundle install
CMD ["bundle", "exec", "rspec", "spec"]
