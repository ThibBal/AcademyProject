#!/bin/bash
#
# This command expects to be run within the Concern FAST profile directory. To
# generate a full distribution you it must be a git checkout.
#
# To use this command you must have `drush make`, `cvs` and `git` installed.
#

if [ -f drupal-org.make ]; then
  echo -e "This command can be used to rebuild the installation profile in place.\n"
  echo -e "  [1] Rebuild profile in place in release mode (latest stable release)"
  echo -e "  [2] Rebuild profile in place in development mode (latest dev code)"
  echo -e "  [3] Rebuild profile in place in development mode (latest dev code with .git working-copy)\n"
  echo -e "Selection: \c"
  read SELECTION

  if [ $SELECTION = "1" ]; then

    echo "Building Open Academy install profile in release mode..."
    drush make --no-core --no-gitinfofile --contrib-destination=. drupal-org-release.make

  elif [ $SELECTION = "2" ]; then

    echo "Building Open Academy install in development mode (latest dev code)..."
    drush make --no-core --no-gitinfofile --contrib-destination=. drupal-org.make

  elif [ $SELECTION = "3" ]; then

    echo "Building Open Academy install profilein development mode (latest dev code with .git working-copy)"
    drush make --working-copy --no-core --no-gitinfofile --contrib-destination=. drupal-org-dev.make

  else
   echo "Invalid selection."
  fi
else
  echo 'Could not locate file "drupal-org.make"'
fi
