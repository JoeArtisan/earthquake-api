FROM ruby:3.2.3
WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client git
RUN git clone https://github.com/JoeArtisan/earthquake-api.git .
RUN bundle install

RUN ruby ./bin/setup
RUN bundle exec rake usgs_gov:get

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
