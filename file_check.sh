#! /bin/bash
site_name=#001

# get new files
rm ./remote/files.txt
./dropbox_uploader.sh list $site_name > ./remote/files.txt

# check state
cmp --silent ./remote/files.txt ./local/files.txt && echo "All good" || echo "files are diff"


if ! cmp ./remote/files.txt ./local/files.txt >/dev/null 2>&1
then
  echo "Doing"
  cp ./remote/files.txt ./local/files.txt
  rm -fR ./remote/$site_name
  ./dropbox_uploader.sh -s download $site_name ./remote
  rm -fR ./local/$site_name
  mv ./remote/$site_name ./local/
fi

# checking git
git pull

chmod +X dropbox_uploader.sh
chmod +X file_check.sh
chmod +X add_feature.sh

./add_feature.sh
