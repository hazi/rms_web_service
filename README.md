# RmsWebService

楽天 RMS Web Service の 非公式 Ruby インターフェイスです。

[![Build Status](https://travis-ci.org/hazi/rms_web_service.svg)](https://travis-ci.org/hazi/rms_web_service)
[![Coverage Status](https://coveralls.io/repos/github/hazi/rms_web_service/badge.svg?branch=master)](https://coveralls.io/github/hazi/rms_web_service?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/81b5f991c1f8126e8822/maintainability)](https://codeclimate.com/github/hazi/rms_web_service/maintainability)

## はじめに

このリポジトリは次のリポジトリのフォークです。

- [fukata/rms_web_service](https://github.com/fukata/rms_web_service)
- [kamiya54/rms_web_service](https://github.com/kamiya54/rms_web_service)

不足しているメソッドの追加や、リファクタリングを行いながら開発中のプロジェクトです。
開発途中のためインターフェイスが変更になります。利用する場合は `ref` を指定して利用することをお勧めします。

### 進捗状況

- :umbrella: ItemAPI => `RmsWebService::Client::Item`
- :snowman: ProductAPI =>
- :cloud: CabinetAPI => `RmsWebService::Client::Cabinet`
- :umbrella: NavigationAPI => `RmsWebService::Client::Navigation`
- :snowman: CategoryAPI =>
- :umbrella: CouponAPI => `RmsWebService::Client::Category`
- :umbrella: ShopManagementAPI => `RmsWebService::Client::ShopManagement`
- :snowman: OrderAPI =>
- :umbrella: InventoryAPI => `RmsWebService::Client::Inventory`
- :snowman: System Event Notification Service =>
- :snowman: RakutenPayOrderAPI =>

:snowman: 実装なし
:umbrella: 利用可能 リファクタリング前
:cloud: 利用可能 リファクタリング済だが、インターフェイス変更の可能性あり
:sunny: 利用可能 リファクタリング済、インターフェイス確定済

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rms_web_service', github: 'hazi/rms_web_service'
# or
gem 'rms_web_service', github: 'hazi/rms_web_service', ref: 'f22b5d4'
```

And then execute:

    $ bundle

## Usage

_現在ドキュメント更新中につき、全てのインターフェイスを網羅できていません。_

### RmsWebService::Client::Item

RmsWebService::Client::Item のインスタンスがAPIの各メソッドを持っています。
各メソッドへのパラメータの渡し方は下記の通りです。

```ruby
item_client = RmsWebService::Client::Item.new(
  service_secret: "dummy_service_secret", license_key: "dummy_license_key")

item = item_client.get("ed-60c-w")
# '.item_name'、'.item_price'等のメソッドを持ちます。属性については公式ドキュメントを見てください。

item = item_client.delete("test001")
# '.success?'で成功したかどうかを判別できます。'.errors'でエラー内容を確認できます。

item = item_client.update({:item_url => "ed-60c-w", :item_price => 43800})
# '.success?'で成功したかどうかを判別できます。'.errors'でエラー内容を確認できます。

item = item_client.insert({
  :item_url => "test001",
  :item_name => "test001",
  :item_price => "100000",
  :genre_id => "211889",
})
# '.success?'で成功したかどうかを判別できます。'.errors'でエラー内容を確認できます。

items = item_client.search(:item_name => "空気清浄機")
# item.getと同じ性質のインスタンスを要素として持つ配列を返します

items = item_client.items_update([
  {:item_url => "ed-60c-w", :item_price => 43800},
  {:item_url => "noexist", :item_price => 10800}
])
# item.updateと同じ性質のインスタンスを要素として持つ配列を返します
```

### RmsWebService::Client::Cabinet

RmsWebService::Client::Cabinet のインスタンスがAPIの各メソッドを持っています。
そのため、まずインスタンスを作成します。

```ruby
cabinet = RmsWebService::Client::Cabinet.new(
  service_secret: "dummy_service_secret", license_key: "dummy_license_key")
```

**画像ファイルをアップロード**

画像ファイルをアップロードには `#upload` または `#file_insert` メソッドを利用します。
両方とも利用方法は同じです。

アップロードには `UploadIO` を利用します。詳細は [Multipart::Post](https://github.com/nicksieger/multipart-post) を確認してください。

```ruby
file = UploadIO.new('/path/to/file.gif', 'image/gif', 'test.gif')
result = cabinet.upload(file: file, folder_id: 0, file_name: 'file')
# or
result = cabinet.file_insert(file: file, folder_id: 0, file_name: 'file')

result #=> RmsWebService::Response::Cabinet::Result
result.success? #=> true
result.file_id #=> "56071092"
```

オプションで `file_path` と `over_write` を指定できます。
`over_write` を `true` にした場合、指定したフォルダ内に同じ `file_path` の画像があった場合に上書きされます。

`over_write` はデフォルトでは `false` になっています。

```ruby
cabinet.upload(
  file: file, folder_id: 0, file_name: 'file',
  file_path: 'file.gif', over_write: true)
```

**画像情報の変更**

登録済みの画像情報の上書きを行うには `#update` または `#file_update` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
# 画像名の変更
cabinet.update(file_id: 168430384, file_name: "新しいカメラ")
# or
cabinet.file_update(file_id: 168430384, file_name: "新しいカメラ")

# file名 の変更
cabinet.update(file_id: 168430384, file_path: "new_camera.jpg")

# 画像 の変更
file = UploadIO.new('/path/to/new_camera_image.jpg', 'image/jpeg', 'new_camera_image.jpg')
cabinet.update(file_id: 168430384, file: file)
```

**フォルダを作成**

フォルダの作成には `#create_folder` または `#folder_insert` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
result = cabinet.create_folder(folder_name: 'カメラ製品')
# or
result = cabinet.folder_insert(folder_name: 'カメラ製品')

result #=> RmsWebService::Response::Cabinet::Result
result.success? #=> true
result.folder_id #=> "23150"
```

オプションで、`directory_name` と `upper_folder_id` を指定できます。

```ruby
result = cabinet.create_folder(
  folder_name: 'カメラ製品', directory_name: 'cameras', upper_folder_id: 23149)
```

**フォルダの一覧を取得**

フォルダの一覧を取得には `#folder_files` または `#folders_get` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
result = cabinet.folders
# or
result = cabinet.folders_get

result #=> RmsWebService::Response::Cabinet::Folders
result.folder_all_count #=> "120"
result.folder_count #=> "20"
result.folders #=> Array

result.folders.first
=> {
  folder_id: "3214",
  folder_name: "カメラ製品",
  folder_node: "1",
  folder_path: "/cameras",
  file_count: "325",
  file_size: "1505.800",
  time_stamp: "2018-06-22 12:08:40"}
```

オプションで `offset` と `limit` を指定できます。
`offset` はページ数を指定し、`limit` は1ページに返却する画像の数を指定します。

`offset` はデフォルトで `1`、`limit` はデフォルトで `100`です。
`limit` の最大値は `100` です。

```ruby
# 2ページめを取得
cabinet.folders(offset: 2)
```

**フォルダ内の画像一覧を取得**

フォルダ内の画像一覧を取得には `#folder_files` または `#folder_files_get` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
result = cabinet.folder_files(folder_id: 3214)
# or
result = cabinet.folder_files_get(folder_id: 3214)

result #=> RmsWebService::Response::Cabinet::Files
result.success? #=> true
result.file_all_count #=> "325"
result.file_count #=> "100"
result.files #=> Array

result.files.first
=> {
  folder_id: "3214"
  folder_name: "カメラ製品"
  folder_node: "1"
  folder_path: "/cameras"
  file_id: "168430384"
  file_name: "すごいカメラの画像"
  file_url: "https://image.rakuten.co.jp/SHOP/cabinet/cameras/img168430384.jpg"
  file_path: "img168430384.jpg"
  file_type: "1" #=> "1": JPEG, "2": GIF, "3": Animation GIF
  file_size: "436.400"
  file_width: "631"
  file_height: "631"
  file_access_date: Fri, 22 Jun 2018, #=> Date
  time_stamp: "2018-06-22 12:08:40" }
```

オプションで `offset` と `limit` を指定できます。
`offset` はページ数を指定し、`limit` は1ページに返却する画像の数を指定します。

`offset` はデフォルトで `1`、`limit` はデフォルトで `100`です。
`limit` の最大値は `100` です。

```ruby
# ２ページ目を取得
result = cabinet.folder_files(folder_id: 3214, offset: 2)
```

**画像を検索**

画像を検索するには `#search` または `#files_search`メソッドを利用します。
両方とも利用方法は同じです。

- `file_id`, `file_path`, `file_name` いずれかを必ず指定して検索を行います。
  複数指定した場合、`file_id` > `file_path` > `file_name` の優先順位で検索します。
- `folder_id`, `folder_path` を指定した場合には該当のフォルダ内を検索します。
  両方指定した場合は、`folder_id` を優先して検索します。
- `offset` ではページ番号を指定します。デフォルトは `1` です。
- `limit` は1ページに返却する画像の数を指定します。デフォルトは `100` で、最大値は `100` です。

```ruby
result = cabinet.search(file_name: "すごいカメラの画像")
# or
result = cabinet.files_search(file_path: "img168430384.jpg", folder_id: "3214")

result #=> RmsWebService::Response::Cabinet::Files
result.file_all_count #=> "1"
result.file_count #=> "1"
result.files #=> Array

result.files.first
=> {
  folder_id: "3214",
  folder_name: "カメラ製品",
  folder_node: "1",
  folder_path: "/cameras",
  file_id: "168430384",
  file_name: "すごいカメラの画像",
  file_url: "https://image.rakuten.co.jp/SHOP/cabinet/cameras/img168430384.jpg",
  file_path: "img168430384.jpg",
  file_type: "1", #=> "1": JPEG, "2": GIF, "3": Animation GIF
  file_size: "436.400"
  file_width: "631"
  file_height: "631"
  file_access_date: Fri, 22 Jun 2018, #=> Date
  time_stamp: "2018-06-22 12:08:40" }
```

**画像を削除フォルダに移動**

画像を削除フォルダに移動するには `#delete` または `#file_delete` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
result = cabinet.delete(51294)
# or
result = cabinet.file_delete(51294)

result #=> RmsWebService::Response::Cabinet::Result
result.success? #=> true
```

_ファイルの完全な削除は API からは行えませんが、削除フォルダに移動後一定期間で自動的に削除されます。_

**削除した画像の一覧を取得**

削除フォルダ内にある削除した画像の一覧を取得には `#trashbox_files` または `#trashbox_files_get` メソッドを利用します。

```ruby
result = cabinet.trashbox_files
# or
result = cabinet.trashbox_files_get

result #=> RmsWebService::Response::Cabinet::Files
result.file_all_count #=> "1"
result.file_count #=> "1"
result.files #=> Array
result.files.first
=> {
  folder_node: "1",
  folder_path: "/cameras",
  file_id: "168430384",
  file_name: "すごいカメラの画像",
  file_url: "https://image.rakuten.co.jp/SHOP/cabinet/cameras/img168430384.jpg",
  file_path: "img168430384.jpg",
  file_type: "1", #=> "1": JPEG, "2": GIF, "3": Animation GIF
  file_size: "436.400"
  file_width: "631"
  file_height: "631"
  file_access_date: Fri, 22 Jun 2018, #=> Date
  time_stamp: "2018-06-22 12:08:40" }
```

オプションで `offset` と `limit` を指定できます。
`offset` はページ数を指定し、`limit` は1ページに返却する画像の数を指定します。

`offset` はデフォルトで `1`、`limit` はデフォルトで `100`です。
`limit` の最大値は `100` です。

```ruby
# 2ページめを取得
cabinet.trashbox_files(offset: 2)
```

**画像の復元**

削除フォルダ内にある画像を指定したフォルダに戻すには `#restore` または `#trashbox_file_revert` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
cabinet.restore(file_id: 168430384, folder_id: 3214)
# or
cabinet.trashbox_file_revert(file_id: 168430384, folder_id: 3214)
```

**R-Cabinet の利用状況を取得**

R-Cabinet の利用状況を取得するには `#usage` または `#usage_get` メソッドを利用します。
両方とも利用方法は同じです。

```ruby
result = cabinet.usage
# or
result = usage_get.usage

result #=> RmsWebService::Response::Cabinet::Usage
result.max_space #=> "5000" 契約容量 (MB)
result.folder_max #=> "500" フォルダ数上限
result.file_max #=> "500" フォルダ内画像数上限
result.use_space #=> "100.000" 利用容量 (KB)
result.avail_space #=> "499900.000" 利用可能容量 (KB)
result.use_folder_count #=> "1" 利用フォルダ数
result.avail_folder_count #=> "499" 利用可能フォルダ数
```

### RmsWebService::Client::Navigation

基本的には `RmsWebService::Client::Item` 同様の利用方法になります。
詳細は公式ドキュメント、コードを見て確認してください。

### RmsWebService::Client::Category

基本的には `RmsWebService::Client::Item` 同様の利用方法になります。
詳細は公式ドキュメント、コードを見て確認してください。

### RmsWebService::Client::ShopManagement

基本的には `RmsWebService::Client::Item` 同様の利用方法になります。
詳細は公式ドキュメント、コードを見て確認してください。

### RmsWebService::Client::Inventory

基本的には `RmsWebService::Client::Item` 同様の利用方法になります。
詳細は公式ドキュメント、コードを見て確認してください。

## Contributing

1. Fork it ( https://github.com/hazi/rms_web_service/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
