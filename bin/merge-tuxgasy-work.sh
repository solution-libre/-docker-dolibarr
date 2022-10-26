#!/usr/bin/env sh

CWD=$(pwd)
DIR='tuxgasy-dolibarr'

cmd_check() {
  cmd=$1
  if ! command -v "$cmd" > /dev/null
  then
    echo "$cmd is require and could not be found. Please install it."
    exit 1
  fi
}

cmd_check 'git'

if ! git filter-repo --version > /dev/null 2>&1
then
    echo "git-filter-repo is require and could not be found. Please install it."
    exit 2
fi

cd /tmp || exit

git clone https://github.com/tuxgasy/docker-dolibarr.git "${DIR}"
cd "${DIR}" || exit

git remote rm origin

git filter-repo --force\
  --path-rename LICENSE:tuxgasy/LICENSE\
  --path-rename examples/with-pgsql/docker-compose.yml:tuxgasy/docker-compose.yml\
  --path-rename examples/with-secrets/env/dolibarr.env:tuxgasy/env/dolibarr.env\
  --path-rename examples/with-secrets/secrets/dolibarr_admin_password.secret:tuxgasy/secrets/dolibarr_admin_password.secret\
  --path-rename examples/with-secrets/secrets/dolibarr_admin_username.secret:tuxgasy/secrets/dolibarr_admin_username.secret\

git filter-repo --force\
  --path tuxgasy

git reset --hard
git gc --aggressive 
git prune
git clean -fd

echo 'DOLI_DB_TYPE=pgsql' >> tuxgasy/env/dolibarr.env
sed -i\
  -e 's/\(DOLI_DB_HOST=\).*/\1postgres/'\
  -e 's/\(DOLI_DB_HOST_PORT=\).*/\15432/'\
  tuxgasy/env/dolibarr.env

sed -i\
  -e '2,7 s/./# &/'\
  -e '19,29 s/./# &/'\
  -e '33,35 s/./# &/'\
  -e '39,41 s/./# &/'\
  -e '44,45 s/./# &/'\
  tuxgasy/docker-compose.yml

git add tuxgasy
git commit -m 'Adjustments of Tuxgasy files'

cd "${CWD}" || exit

git remote add tuxgasy "/tmp/${DIR}"
git fetch tuxgasy
git rebase tuxgasy/master

git remote remove tuxgasy
rm -rf "/tmp/${DIR}"
