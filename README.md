# 提出Quest「RealWorld」

ブログプラットフォームを作る [RealWorld](https://github.com/gothinkster/realworld/tree/main) という OSS のプロジェクトがあります。RealWorld は実世界と同じ機能を持つプラットフォームを作ることで、学習したいフレームワークの技術を習得することを目的としてたプロジェクトです。

ここでは、[RealWorld の バックエンドの API](https://realworld-docs.netlify.app/docs/specs/backend-specs/introduction) の仕様を満たす Rails API を作成します。

ステップ1とステップ2に分かれます。時間に余裕がない場合はステップ1に進んでください。時間に余裕がある場合はステップ2に進んでください。ステップ1を終えてからステップ2に進む設計にはなっていないため、最初にどちらに進むかを選択してください。

ステップ1は RealWorld の API の仕様を部分的に満たした API を作成します。具体的には、認証機能のない簡易バージョンの作成になります。

ステップ2は RealWorld の API の仕様を満たす API を作成します。認証機能付きのバージョンの作成になります。

基本的にはステップ2を進めていくことを想定していますが、時間に余裕がない場合はステップ1を進めてください。

[RealWorld のドキュメント](https://realworld-docs.netlify.app/docs/intro) に目を通した上で、ステップに進んでください。

## ステップ1

RealWorld の API のうち、次のエンドポイントを実装してください。

- [Create Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#create-article)
- [Get Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#get-article)
- [Update Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#update-article)
- [Delete Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#delete-article)

なお、Article に関わる要素のうち、認証機能及び著者、お気に入り(`favorite`) は実装しなくてよいものとします。

## ステップ2

### 2-1

RealWorld の API のうち、次のエンドポイントを実装してください。

- [Registration](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#registration)

その際に、[API spec](https://github.com/gothinkster/realworld/tree/main/api) と呼ばれている [Postman のテスト(Conduit.postman_collection.json)](https://github.com/gothinkster/realworld/blob/main/api/Conduit.postman_collection.json)の該当する箇所が通るように実装してください(該当箇所以外のテストは削除するとテストしやすいです)。

### 2-2

次のエンドポイントを実装してください。

- [Authentication](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#authentication)

その際に、Postman のテストの該当する箇所が通るように実装してください。

### 2-3

次のエンドポイントを実装してください。

- [Create Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#create-article)
- [Get Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#get-article)
- [Update Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#update-article)
- [Delete Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#delete-article)

その際に、Postman のテストの該当する箇所が通るように実装してください。

なお、Article に関わる要素のうち、お気に入り(`favorite`) は実装しなくてよいものとします。Postman のテストからも該当箇所のコードは削除し除外してください。

### 2-4

いずれかのエンドポイントのテストを1つ書いてください。

### 2-5 (advanced)

お気に入り(`favorite`)も実装してください。

# デプロイ
フロントエンド：https://nextjs-realworld-iota.vercel.app/ <br>
バックエンド  ：https://mystudysite/api/

# アーキテクチャ
![realworld-architecture](https://github.com/takuya-38/RealWorld/assets/128199416/356af767-d798-43f2-88f3-deae21e0e9fd)

# API設計

## リクエストライン

| HTTPメソッド | URL |説明|
| ---- | ---- | ---- |
|   POST   |   /api/users   | ユーザー作成 |
|   POST   |   /api/users/login   | トークン取得 |
|   GET   |   /api/articles/:id   | 記事取得 |
|   POST   |   /api/articles/:id   | 記事作成 |
|   PATCH   |   /api/articles/:id   | 記事更新 |
|   DELETE   |   /api/articles/:id   | 記事削除 |

## Registration
```
  POST http://127.0.0.1:3000/api/users
```
### リクエストボディの例
```
{
  "user":{
    "username": "Jacob",
    "email": "jake@jake.jake",
    "password": "jakejake"
  }
}
```

### レスポンスボディの例
```
{
    "user": {
        "id": 1
        "username": "Jacob",
        "email": "jake@jake.jake",
        "bio": null,
        "image": null,
        "password_digest": "$2a$12$khtYBCmCjfDvw5PCqxq.z.4b.Gxzvf5ns1sJtV0YyxxOJ6udzj2oC",
        "token": null,
        "created_at": "2024-01-07T09:33:00.248Z",
        "updated_at": "2024-01-07T09:33:00.248Z"
    }
}
```

## Authentication
```
  POST http://127.0.0.1:3000/api/users
```
### リクエストボディの例
```
{
  "user":{
    "email": "jake@jake.jake",
    "password": "jakejake"
  }
}
```

### レスポンスボディの例
```
{
    "user": {
        "id": 1,
        "username": "Jacob",
        "email": "jake@jake.jake",
        "bio": null,
        "image": null,
        "password_digest": "$2a$12$VIdO9Lnnk69rHJaXDsCVAuBSAILIKraP7OLaC4YgED5R2gSKV23tG",
        "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MDcyOTg0OTJ9.Q6GIZhpSfgzUFusmOoltgOF5cc8gizaENtZsMeu7lcE",
        "created_at": "2024-01-07T08:17:39.433Z",
        "updated_at": "2024-01-07T08:17:39.433Z"
    }
}
```

## Create Article
```
  POST http://127.0.0.1:3000/api/articles/:id
```
### リクエストボディの例
```
{
  "article": {
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "You have to believe",
    "tagList": ["reactjs", "angularjs", "dragons"]
  }
}
```

### レスポンスボディの例
```
{
    "article": {
        "slug": 1,
        "title": "How to train your dragon",
        "description": "Ever wonder how?",
        "body": "You have to believe",
        "tagList": [],
        "author": null,
        "createdAt": "2024-01-07T09:36:07.308Z",
        "updatedAt": "2024-01-07T09:36:07.308Z"
    }
}
```

## Get Article
```
  GET http://127.0.0.1:3000/api/articles/:id
```

### レスポンスボディの例
```
{
    "article": {
        "slug": 1,
        "title": "How to train your dragon",
        "description": "Ever wonder how?",
        "body": "You have to believe",
        "tagList": [
            "reactjs",
            "angularjs",
            "dragons"
        ],
        "author": null,
        "createdAt": "2024-01-07T08:19:01.432Z",
        "updatedAt": "2024-01-07T08:19:01.432Z"
    }
}
```

## Update Article
```
  PATCH http://127.0.0.1:3000/api/articles/:id
```
### リクエストボディの例
```
{
  "article": {
    "title": "Did you train your dragon?"
  }
}
```

### レスポンスボディの例
```
{
    "article": {
        "slug": 1,
        "title": "Did you train your dragon?",
        "description": "Ever wonder how?",
        "body": "You have to believe",
        "tagList": [
            "reactjs",
            "angularjs",
            "dragons"
        ],
        "author": null,
        "createdAt": "2024-01-07T08:19:01.432Z",
        "updatedAt": "2024-01-07T09:37:29.908Z"
    }
}
```

## Delete Article
```
  DELETE http://127.0.0.1:3000/api/articles/:id
```
指定したidのデータが存在しない場合（削除完了した場合）、HTTPステータス 204 No Contentが返ってくる。
