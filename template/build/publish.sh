# npm run build

# Define some colours
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color
REMOTE=blacksheepdesign@202.37.129.249

printf "# ${GREEN}Starting migration ...${NC}\n"
printf "# ========================"
echo
read -p 'Site domain: ' publish_domain

if ssh $REMOTE "[ ! -d /var/www/$publish_domain/site_files/htdocs ]"; then
  echo
  printf "# ${RED}This site doesn't exist on the server, you should first run the make-site script ...${NC}\n"
  exit 0
else
  copy_db=false

  while true; do
      read -p "Would you like to push the database to remote? [y/n] " yn
      case $yn in
        [Yy]*)
          copy_db=true; break;;
        [Nn]*)
          copy_db=false; break;;
        * ) echo "Please answer yes or no.";;
      esac
  done

  if [ "$copy_db" = true ]; then
    echo

    if [[ -f dev-database.sql ]]; then
      printf "# ${GREEN}Backing up dev-database.sql ...${NC}\n"
      cp dev-database.sql dev-database.sh.backup
      echo
    fi

    printf "# ${GREEN}Getting a copy of the local database ...${NC}\n"

    vagrant ssh -- 'mysqldump wordpress -u root > /vagrant/dev-database.sql'

    scp -q dev-database.sql $REMOTE:/tmp/

    if ssh $REMOTE "[ -f /var/www/$publish_domain/site_files/htdocs/wp-config.php ]"; then
      echo
      printf "# ${GREEN}Getting configuration data ...${NC}\n"

      DB_NAME=$(ssh ${REMOTE} "cat /var/www/${publish_domain}/site_files/htdocs/wp-config.php | grep DB_NAME | cut -d \' -f 4")
      DB_USER=$(ssh ${REMOTE} "cat /var/www/${publish_domain}/site_files/htdocs/wp-config.php | grep DB_USER | cut -d \' -f 4")
      DB_PASSWORD=$(ssh ${REMOTE} "cat /var/www/${publish_domain}/site_files/htdocs/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4")

      ssh $REMOTE "mysqldump --databases $DB_NAME -u $DB_USER -p$DB_PASSWORD > /var/www/${publish_domain}/site_files/htdocs/prod-database.sql.backup"

    else
      echo
      printf "# ${GREEN}Wordpress is not configured on the remote server. Configuring now ...${NC}\n"

      read -p 'Remote database name: ' DB_NAME
      read -p 'Remote database user: ' DB_USER
      read -p 'Remote database password: ' DB_PASSWORD

      ssh $REMOTE "cd /var/www/${publish_domain}/site_files/htdocs/ && wp core download && wp core config --dbname=$DB_NAME --dbpass=$DB_PASSWORD --dbuser=$DB_USER"

      echo
      printf "# ${GREEN}Cleaning up ...${NC}\n"
      ssh $REMOTE "rm /tmp/dev-database.sql"
      echo

      printf "# ${GREEN}Wordpress has been configured.${NC}\n"
      echo
      echo '    You should login to http://{{ name }}.blacksheep.design/ and set a site name, a user and permalinks before continuing.'
      echo "    This script will now exit, however when you're ready to continue you can re-run this script to continue pushing the site live."
      echo
      #exit 0
    fi

    ssh $REMOTE "cd /var/www/${publish_domain}/site_files/htdocs/ && mysql --database $DB_NAME -u $DB_USER -p$DB_PASSWORD < /tmp/dev-database.sql && wp search-replace '{{ name }}-local.bsd.nz' '$publish_domain' > /dev/null"

  fi

fi

rsync -r html/wp-content/themes/{{ name }}/ $REMOTE:/var/www/${publish_domain}/site_files/htdocs/wp-content/themes/{{ name }}/

echo

printf "# ${GREEN}Done!${NC}\n"
