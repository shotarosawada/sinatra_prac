## インストール手順

### リポジトリ複製
git clone https://github.com/shotarosawada/sinatra_prac.git

### gem
gem install sinatra
gem install puma
gem install active_record
gem install sqlite3

### 初期化SQL
sqlite3 zipcode.db < dbinit.sq3

### 起動
ruby app.rb

### デフォルトのアクセスポイント
http://127.0.0.1:4567

## 動作環境
### ruby -v
ruby 3.0.4p208 (2022-04-12 revision 3fa771dded) [x64-mingw32]

### gem -v
3.3.24

### sqlite3
SQLite version 3.39.4 2022-09-29 15:55:41

### systeminfo抜粋
OS 名:                  Microsoft Windows 11 Pro
OS バージョン:          10.0.22000 N/A ビルド 22000
プロセッサ:             1 プロセッサインストール済みです。
                        [01]: AMD64 Family 25 Model 80 Stepping 0 AuthenticAMD ~1901 Mhz
BIOS バージョン:        AMI F.05, 2021/09/15
ホットフィックス:       4 ホットフィックスがインストールされています。
                        [01]: KB5017264
                        [02]: KB5012170
                        [03]: KB5018418
                        [04]: KB5017850
