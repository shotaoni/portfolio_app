# ポートフォリオ紹介

「tante」は探偵を利用したことがある人、探偵会社を探している人達が集まって情報交換ができるメディアサービスです。
スマートフォンに対応していますので気軽にご利用してみてください!

## アピールポイント

＊ フロントエンドとバックエンドを分けた完全SPA構成で作成した点。
* terraformでインフラ環境をコード管理している点。
* Codepipelineを使用しCI／CD環境を構築している点。

## トップページ

<img src="https://user-images.githubusercontent.com/74387670/115364989-ea52eb80-a1fe-11eb-9a59-20c2ae872e79.png" width="443px">

#### 使用した技術

* 言語
  * Ruby 2.7.1
* フレームワーク
  * バックエンド Rails 6.0.3.6 (APIモード)
  * フロントエンド Nuxt.js 2.14.12
* 使用した主なGem
* 
* UIコンポーネント @nuxtjs/vuetify 1.11.3
* データベース
  * MySQL 5.7
* テスト
  * フロントエンド　jest
  * バックエンド　RSpec
* コードフォーマッター
  * フロントエンド ESlint
  * バックエンド Rubocop
* 開発環境
  * Docker 20.0.2
  * Docker-compose 1.27.4
* インフラコード管理
  * Terraform 0.14.7
* インフラ
  * AWS (VPC,S3,ACM,Route53,ALB,ECR,ECS(Fargate),SSM,RDS,CloudWatch,CodePipeline)


## ER図

![ER](https://user-images.githubusercontent.com/74387670/115243773-3bf76980-a15e-11eb-81f8-f508335104e5.png)

## インフラ構成図

![AWS](https://user-images.githubusercontent.com/74387670/115243800-41ed4a80-a15e-11eb-892f-2c6c64b19140.png)

## 機能一覧

* ユーザー設定
 * 新規登録、ログイン、ログアウト
 * ユーザ情報編集、アカウント削除
 * プロフィール画像設定、編集
* 投稿
 * 記事投稿、編集、削除
 * 画像投稿
 * リンクカード投稿、表示
 * いいね機能
 * コメント、コメント削除
* その他機能
 * フラッシュ
 * フォロー、フォロワー　フォロー一覧、フォロワー一覧
 * フィード機能　全ての投稿、自分の投稿フィード、フォローユーザの投稿フィード、いいねした投稿フィード
 * 検索　投稿検索、ユーザ検索、コメント検索
 * 通知　フォロー、コメント、いいねされると通知
 * ページネーション
