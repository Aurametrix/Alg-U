$seats="$(curl $URL | sed \"140qd\" | sed -nE \"s/<TD CLASS=\"$CLASS\">|<\\/TD>//gp\")"
  if [ $seats -gt 0 ]; then
      echo "Go register for class $URL" | msmtp -a "default" $EMAIL"
  fi
