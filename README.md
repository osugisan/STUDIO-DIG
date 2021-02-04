# スタジオディグ

## アプリケーション紹介動画
[こちらからご覧ください(YOUTUBEへ遷移します)](https://www.youtube.com/watch?v=E-DYfkHip_A)

<img src="readme.PNG" width="750"/>

## アプリケーション概要

「スタジオディグ」は、個人開発アプリケーションとして制作した自作WEBアプリケーションです。<br>
<br>
お気に入りの音楽スタジオを共有し、口コミレビューやいいねを送り合ってコミュニケーションを取ることができます。<br>
製作背景については、下記に記します。<br>
<br>
Google Maps APIを導入し、投稿した住所情報から店舗地図の表示。また、現在地からスタジオを探す機能の実装しユーザーにとって使いやすい使用感を目指しました。Rspecによるテスト(model,request,system)は、116項目のexampleをパスしました。<br>
<br>
また、UI/UXにも配慮し、使っていて楽しくなるようなWEBアプリを目指して作成しました。<br>
<br>
インフラにつきましては、AWS(EC2, RDS, Route53, ACM, ALB, IAM等)や実行環境をDockerfileにより共有でき、環境構築を容易にするDockerなどのモダンな技術に挑戦しました。<br>
<br>

### サイトテーマ

お気に入りスタジオをディグろう！

### テーマを選んだ理由

私は、学生時代からバンド活動をしており、その活動の中で音楽スタジオを頻繁に利用していました。<br>
名のあるスタジオを利用することもありますが、私は小規模経営されているようなスタジオを「発掘」することが<br>趣味の一つでもありました。<br>
当時は、良いスタジオを発掘したらメンバーに共有したり、逆に良いスタジオがあれば教えてもらったりしていました。<br>
ただ、世の中には私の知らない「穴場スタジオ」が、まだまだ数多く存在しています。<br>
もっと多くの情報が得たいと思い、スタジオディグの着想を得ました。<br>
以上のような背景から、スタジオ版口コミサイトがあれば、より多くの情報を得ることができ、<br>
さらには、世のバンドマンや個人で楽器を演奏する方たちにとっても、役立つのではないかと思いこちらのテーマを選びました。<br>

## 設計書

### 機能一覧

## 使用技術

- HTML
- CSS
- Javascript / JQuery / Ajax
- Ruby 2.5.3 / Slim 記法
- Ruby on Rails 5.2.4 (RSpec / Rubocop による動的静的テスト等も含む)
- MySQL
- Linux (各種コマンド操作)
- Nginx (Web Server)
- Puma (Application Server)
- Git / GitHub (pull request, Issues 等による擬似チーム開発)
- Docker / docker-compose
- AWS 各種サービス
- CircleCI/CD
- Capistrano
- AWS
  <br> EC2 ( Amazon Linux 2 ) / RDS(MySQL) / S3 / VPC / IAM / Route53 / ACM / ALB

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9

## 使用素材

- Font Awesome https://fontawesome.com/
- Font Free https://fontfree.me/
- Ivons8 https://icons8.jp/
- photoAC https://www.photo-ac.com/
