FROM ruby:2.7.6
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 23E7166788B63E1E \
    && gpg --export 23E7166788B63E1E | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y mariadb-client nodejs yarn imagemagick \
    && mkdir /myapp

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#     && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#     && apt-get update -qq \
#     && apt-get install -y mariadb-client nodejs yarn \
#     && mkdir /myapp

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]