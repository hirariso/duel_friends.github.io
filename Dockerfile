FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver 
# yarnとchromium-driverを追記
RUN mkdir /sample_app
WORKDIR /sample_app
COPY Gemfile /sample_app/Gemfile
COPY Gemfile.lock /sample_app/Gemfile.lock
RUN gem install bundler 
# 追記
RUN bundle install
COPY . /sample_app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]