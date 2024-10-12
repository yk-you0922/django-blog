# プロジェクト作成

## 初期構築コマンド
コマンド

```bash
$ docker compose run web django-admin startproject blog .
```

お試し起動

```bash
$ docker compose up -d
```

ローカルアクセス
http://localhost:8000

## 権限関連の注意点

WSL+Dockerでプロジェクトを作成した際、rootで作成されるので編集・保存ができない場合がある。

```bash
user@user:~/work/django-blog$ ls -l
total 32
-rw-r--r-- 1 <your_username> <your_username>  784 Oct 12 11:53 Dockerfile
-rw-r--r-- 1 <your_username> <your_username>  360 Oct 12 12:26 README.md
drwxr-xr-x 3 root       root       4096 Oct 12 11:34 blog
drwxr-xr-x 3 root       root       4096 Oct 12 11:19 docker
-rw-r--r-- 1 <your_username> <your_username>  971 Oct 12 11:31 docker-compose.yml
-rwxr-xr-x 1 root       root        660 Oct 12 11:33 manage.py
drwxr-xr-x 4 <your_username> <your_username> 4096 Oct 12 12:18 memos
-rw-r--r-- 1 <your_username> <your_username>   35 Oct 12 11:52 requirements.txt
```

そのような場合においては下記のコマンドでWSLのユーザーに変更することで対応可能。

※MacのDockerDesktopなどで利用する際には遭遇したことはない。

```bash
sudo chown -R $USER:$USER .

user@user:~/work/django-blog$:~/work/django-blog$ ls -l
total 32
-rw-r--r-- 1 <username> <username>  784 Oct 12 11:53 Dockerfile
-rw-r--r-- 1 <username> <username>  360 Oct 12 12:26 README.md
drwxr-xr-x 3 <username> <username> 4096 Oct 12 11:34 blog
drwxr-xr-x 3 <username> <username> 4096 Oct 12 11:19 docker
-rw-r--r-- 1 <username> <username>  971 Oct 12 11:31 docker-compose.yml
-rwxr-xr-x 1 <username> <username>  660 Oct 12 11:33 manage.py
drwxr-xr-x 4 <username> <username> 4096 Oct 12 12:18 memos
-rw-r--r-- 1 <username> <username>   35 Oct 12 11:52 requirements.txt
```

## .gitignore

[.gitignore](../../.gitignore)

- `docker/db/data/`
  - docker-compose.ymlで作成時のMySQLにて起動時に生成されるバインドしたファイル
  - Git管理する必要がないため `.gitignore` にて指定
- `__pycache__/`, `*.pyc`
  - キャッシュ関連につきコミット不要
- その他は一般的な `.gitignore` に含めるファイルとして指定

## プロジェクトで取り扱うSQLの種類

djangoはデフォルトではsqlite3を利用する。

そのため、 `settings.py` にて下記の箇所を変更する必要がある。

```python
# Database
# https://docs.djangoproject.com/en/5.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'test_database',
        'USER': 'docker',
        'PASSWORD': 'docker',
        'HOST': 'db',
        'PORT': '3306',
    }
}
```

そしてデフォルトで作成される `sqlite3` ファイルを削除する。

## 初期構築時の各種ファイルについて

```bash
.
├── Dockerfile
├── README.md
├── blog
│   ├── __init__.py # blogディレクトリがPythonパッケージであることを周知するためのファイル
│   ├── asgi.py # プロジェクトを実行するためのASGI互換Webサーバーとのエントリーポイント
│   ├── settings.py # Djangoプロジェクトの設定ファイル
│   ├── urls.py # プロジェクトのURL宣言、ルーティング関連
│   └── wsgi.py # プロジェクトを実行するためのWSGI互換Webサーバーとのエントリーポイント
├── docker
│   └── db
│       └── data
├── docker-compose.yml
├── manage.py # プロジェクトの操作を行うCLIユーティリティ
└── requirements.txt # プロジェクトで利用するライブラリの設定記述ファイル
```

ファイル関連リンク集
- manage.py https://docs.djangoproject.com/ja/5.1/ref/django-admin/
- __init__.py
- settings.py https://docs.djangoproject.com/ja/5.1/topics/settings/
- urls.py https://docs.djangoproject.com/ja/5.1/topics/http/urls/
- asgi.py https://docs.djangoproject.com/ja/5.1/howto/deployment/asgi/
- wsgi.py https://docs.djangoproject.com/ja/5.1/howto/deployment/wsgi/