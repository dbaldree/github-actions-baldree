# Start Release

Action that starts the release by creating release branch, updating project
release version, creates RC1 version tag and opens pull request to the `main`
branch. Optionally, it also updates the development branch to the next
preferred development version.

## Usage

To update version number in the project ex: pom.xml file you need to provide
command that will do it

### Examples for Java

To update release version:

```sh
mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$VERSION
```

To update next development version:

```sh
mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$NEXT_DEV_VERSION
```

### Example for Node

To update release version:

```sh
npm --no-git-tag-version version $VERSION
npm install --package-lock-only
```

To update next development version:

```sh
npm --no-git-tag-version version $NEXT_DEV_VERSION
npm install --package-lock-only
```

Depending on your use case you can also provide multiline script that will
update project version

```yaml
update_version_command: |
  cd backend
  mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$VERSION
  cd ../ui
  npm --no-git-tag-version version $VERSION
  npm install --package-lock-only
  cd ..
update_next_dev_version_command: |
  cd backend
  mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$NEXT_DEV_VERSION
  cd ../ui
  npm --no-git-tag-version version $NEXT_DEV_VERSION
  npm install --package-lock-only
  cd ..
```

You can use `$VERSION` as placeholder for the release version and it will be
replaced with correct version when action is executed. Similarly,
`$NEXT_DEV_VERSION` can be used as placeholder for the next development version.

Below you will find example workflow that uses this action

```yaml
name: Start Release

on:
  workflow_dispatch:
    inputs:
      version:
        type: string
        required: true
        description: "Version of new Release"
      next_dev_version:
        type: string
        required: false
        description: "Next development version"

jobs:
  start_release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.ADVARRA_ENGINEERING_ORG_TOKEN }}
      # other steps, like java setup
      - uses: advarra-engineering/action-advarra-workflows/actions/start-release@v1
        with:
          github_token: ${{ secrets.ADVARRA_ENGINEERING_ORG_TOKEN }}
          version: ${{ inputs.version }}
          update_version_command: mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$VERSION
          # The following (updating next development version) is optional.
          next_dev_version: ${{ inputs.next_dev_version }}
          update_next_dev_version_command: mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$NEXT_DEV_VERSION
```
