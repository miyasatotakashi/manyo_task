users
----
|テーブル|カラム|
|---|---|
|name |string|
|email|string|
|password_digest|string|

tasks
---
|テーブル|カラム|
|---|---|
|title|string|
|content|text|

labels
---
|テーブル|カラム|
|---|---|
|label|string|

---

- Herokuへのデプロイ手順をMarkdown記法でREADME.mdに記載する

- Herokuに新規作成 $ heroku create
- Herokuにログイン $ heroku login
- コミット $ git add .
- コミットコメント $ git commit -m "hello heroku"
- Herokuにデプロイする $ git push heroku step2:master
- データベースの移行 $ heroku run rails db:migrate