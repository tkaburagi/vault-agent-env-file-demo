#!/bin/sh

echo ${HELLO_KEY} > kv.txt

# 起動中のメッセージを表示
echo "起動中です..."

# アプリケーションが8080ポートで応答するまで待機
while ! nc -z localhost $PORT; do
  sleep 1
done

rm kv.txt

# 削除が正常に行われたかを確認
if [ $? -eq 0 ]; then
  echo "kv.txtファイルが正常に削除されました。"
else
  echo "kv.txtファイルの削除に失敗しました。"
fi

# 削除後のディレクトリ内容を表示
ls