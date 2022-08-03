FROM ruby:3.1.2-bullseye

WORKDIR /app

COPY Gemfile Gemfile.lock register_sources_psc.gemspec /app/
COPY lib/register_sources_psc/version.rb /app/lib/register_sources_psc/

RUN bundle install

COPY . /app/

CMD ["bundle", "exec", "rspec"]
