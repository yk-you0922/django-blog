# Djangoお試しプロジェクト

## 概要

ブログアプリでお試し作成メモ

## 構成

- django5.0
- mysql8.0

## プロジェクト作成

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