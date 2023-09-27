#!/bin/bash

# variable declaration
option_message="次の選択肢から入力してください(Add Password/Get Password/Exit)："

# welcome message
echo "パスワードマネージャーへようこそ！"
echo "$option_message"

while : ; do
  read option

  # 1. Add Password
  if [ "$option" = "Add Password"] ; then
    echo "サービス名を入力してください："
    read service_name
    echo "ユーザー名を入力してください："
    read user_name
    echo "パスワードを入力してください："
    read password
    echo "$service_name:$user_name:$password" >> data.txt
    echo "パスワードの追加は成功しました"
    echo "$option_message"

  # 2. Get Password
  elif [ "$option" = "Get Password" ] ; then
    echo "サービス名を入力してください："
    read service_name_sample
    accord_flag="False"
    while read line ; do
    each_service_name=`echo "$line" | cut -d ':' -f1`
      if [ "$service_name_sample" = "$each_service_name" ] ; then
        echo "サービス名：`echo "$line" | cut -d ':' -f1`"
        echo "ユーザー名：`echo "$line" | cut -d ':' -f2`"
        echo "パスワード：`echo "$line" | cut -d ':' -f3`"
        accord_flag="True"
      fi
    done < data.txt
    if [ "$accord_flag" = "False" ] ; then
      echo "そのサービスは保存されていません。"
    fi
    echo "$option_message"s

  # 3. Exit
  elif [ "$option" = "Exit" ] ; then
    echo "Thank you!"
    break
  
  else
    echo "入力が間違っています。Add Password/Get Password/Exit から入力してください。"

  fi
done