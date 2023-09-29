#!/bin/bash

option_flag="4"

if [ "$option_flag" = "0" ] || [ "$option_flag" = "1" ] || [ "$option_flag" = "3" ] ; then
  echo "$option_flag"
elif [ "$option_flag" = "4" ] ; then
  echo "$option_flag"
else
  echo "error"
fi