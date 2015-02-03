# Define upload method
if [ "$METHOD" = "upload" ]; then

  # Set folder permissions
  find httpdocs/* -type d -print0 | xargs -0 chmod 0755
  find httpdocs/* -type f -print0 | xargs -0 chmod 0644
  chmod -R 0777 httpdocs/cache

  # Get remote config
  REMOTE=$( getConfigVar "REMOTE" )

  # Run rsync command
  rsync -trp --omit-dir-times --delete --exclude=cache/images --exclude=cache/tmp --exclude=cache/null httpdocs/ $REMOTE

  # Upload to CDN
  grunt cloudfiles

  # Show complete text
  echo $HR
  echo $UPLOAD
  echo $HR