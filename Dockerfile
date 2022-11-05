FROM ruby:2.7.5

RUN apt-get update -qq
RUN apt-get install -y build-essential \
    nodejs \
    postgresql-client \
    curl \
    nodejs \
    gawk \
    autoconf \
    automake \
    bison \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libsqlite3-dev \
    libtool \
    libyaml-dev \
    pkg-config \
    sqlite3 \
    zlib1g-dev \
    libgmp-dev \
    libreadline-dev \
    libssl-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

# CMD puma -C config/puma.rb
# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
