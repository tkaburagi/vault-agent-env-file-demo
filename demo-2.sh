#!/bin/sh

ENDPOINT="http://localhost:8080/health"

echo ${HELLO_KEY} > kv.txt

java -jar myapp-0.0.1-SNAPSHOT.jar

# 起動中のメッセージを表示
echo "起動中です..."

# アプリケーションが起動するまで待機
while true; do
  # HTTPリクエストを送信してHTTPコードを取得
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $ENDPOINT)

  # HTTPコードが200の場合、起動完了とみなす
  if [ $HTTP_CODE -eq 200 ]; then
    echo "アプリケーションが起動しました。"
    break
  fi

  # 1秒待機して再試行
  sleep 1
done

rm kv.txt
