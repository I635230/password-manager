#!/bin/bash

# variable declaration
option_message="次の選択肢から入力してください(Add Password/Get Password/Exit)："
option_message_2="入力が間違っています。Add Password/Get Password/Exit から入力してください。"
option_flag="0" # 0:1st lap, 1:Add Password, 2:Get Password, 3:Exit, 4:Exception

# welcome message
echo "パスワードマネージャーへようこそ！"

# option loop
while : ; do
  ## Option message
  if [ "$option_flag" = "0" ] || [ "$option_flag" = "1" ] || [ "$option_flag" = "2" ] ; then
    echo "$option_message"
  elif [ "$option_flag" = "4" ] ; then
    echo "$option_message_2"
  else
    echo "option_flag error"
  fi

  ## input
  read option
  option=`echo "$option" | tr '[:upper:]' '[:lower:]'`
  ## 1. Add Password
  if [ "$option" = "add password" ] ; then
    ### input
    echo "サービス名を入力してください："
    read service_name
    service_name=`echo "$service_name" | tr '[:upper:]' '[:lower:]'`        
    echo "ユーザー名を入力してください："
    read user_name
    echo "パスワードを入力してください："
    read password
    add_content="$service_name:$user_name:$password"

    ### encrypt
    origin_content=`gpg -d data.txt.gpg` 2> /dev/null
    rm data.txt.gpg 2> /dev/null
    echo "$origin_content\n$add_content" > data.txt
    gpg -c data.txt
    rm data.txt
    echo "パスワードの追加は成功しました"
    option_flag="1"

  ## 2. Get Passwords
  elif [ "$option" = "get password" ] ; then  
    ### input
    echo "サービス名を入力してください："
    read service_name_sample
    service_name_sample=`echo "$service_name_sample" | tr '[:upper:]' '[:lower:]'`        
    accord_flag="False"

    ### decrypt and output
    content=`gpg -d data.txt.gpg` 2> /dev/null
    while read line ; do
    each_service_name=`echo "$line" | cut -d ':' -f1`
      if [ "$service_name_sample" = "$each_service_name" ] ; then
        echo "サービス名：`echo "$line" | cut -d ':' -f1`"
        echo "ユーザー名：`echo "$line" | cut -d ':' -f2`"
        echo "パスワード：`echo "$line" | cut -d ':' -f3`"
        accord_flag="True"
      fi
    done < <(echo "$content")

    if [ "$accord_flag" = "False" ] ; then
      echo "そのサービスは登録されていません。"
    fi
    option_flag="2"

  ## 3. Exit
  elif [ "$option" = "exit" ] ; then
    echo "Thank you!"
    option_flag="3"
    break
  
  ## 4. Exception
  else
    option_flag="4"

  fi
done