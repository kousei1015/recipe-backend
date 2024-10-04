FROM ruby:3.3.4

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim \
                       default-mysql-client

# アプリケーションディレクトリを作成
RUN mkdir /app
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# bundlerをインストールしてgemをインストール
RUN gem install bundler
RUN bundle install --without test development
# アプリケーションのソースコードをコピー
ADD . /app

ENV RAILS_ENV="production"
ENV RAILS_LOG_TO_STDOUT="true" 
# ポート3000を開放
EXPOSE 3000

# entrypointのスクリプトをコピーして実行権限を付与
COPY prd/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# entrypointのスクリプトを設定
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# CMD で サーバーを起動
# pumaで動作させる場合
# CMD ["bundle", "exec", "puma", "-C", "/app/config/puma.rb"]
# unicornで動作させる場合
CMD ["bundle", "exec", "unicorn", "-p", "3000", "-c", "/app/config/unicorn.rb", "-E", "production"]