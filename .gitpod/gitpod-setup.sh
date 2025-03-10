#!/usr/bin/env bash

# Convert context URL to an array
mapfile -t CONTEXT_URL_ITEMS < <(echo "$GITPOD_WORKSPACE_CONTEXT_URL" | tr '/' '\n')

# Check if Gitpod started from a specific example directory in the repository
if [ "${CONTEXT_URL_ITEMS[7]}" = "examples" ]; then
    EXAMPLE_PROJECT=${CONTEXT_URL_ITEMS[8]}
# Check it Gitpod started with $ASTRO_NEW environment variable
elif [ -n "$ASTRO_NEW" ]; then
    reponame="ASTRO_NEW"
    echo $reponame
    //clone from git repo and base on  examples 
    git clone ${ASTRO_NEW} ${GITPOD_REPO_ROOT}/examples/${reponame}

    EXAMPLE_PROJECT="$reponame"
# Otherwise, set the default example project - 'starter'
else
    EXAMPLE_PROJECT="starter"
fi

# Wait for VSCode to be ready (port 23000)
gp ports await 23000 > /dev/null 2>&1

echo "Loading example project:" $EXAMPLE_PROJECT

# Go to the requested example project
cd "$GITPOD_REPO_ROOT"/examples/"$EXAMPLE_PROJECT" || exit
# Open the main page in VSCode
code src/pages/index.astro

# Start Astro
pnpm start
