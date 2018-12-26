#!/usr/bin/env bash

######################################
# Created By Golansho
#
# Date - 25/12/18
#
# Purpose : Creating a new script with a template
#
# Ver : 1.0.0
#
######################################

set -x         # For debuging purpose
{
printf "#!/usr/bin/env bash\n"

printf "######################################\n"
printf "# Created By Golansho\n"
printf "#\n"
printf "# Date -\n" 
printf "#\n"
printf "# Purpose : \n"
printf "#\n"
printf "# Ver : 1.0.0\n"
printf "######################################\n"
}  >>~/Desktop/ShellOut/newscript.sh
     vi ~/Desktop/ShellOut/newscript.sh


