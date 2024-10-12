# 公式のPythonランタイムを親イメージとして使用
FROM python:3.13-alpine3.20

# コンテナ内の作業ディレクトリを設定
WORKDIR /code

# requirements.txtに指定されている必要なパッケージをインストール
RUN apk add --no-cache mariadb-dev build-base pkgconfig

# コンテナにrequirements.txtをコピー
COPY requirements.txt /code/

# requirements.txtに指定されているパッケージをインストール
RUN pip install -r requirements.txt

# その他のアプリケーションをコードにコピー
COPY . /code/

# 静的ファイルを収集
RUN python manage.py collectstatic --noinput

# gunicornを使ってDjangoアプリケーションを起動
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "blog.wsgi:application"]