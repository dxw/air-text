To upgrade Node, update the version number in the following files:

- `.node-version`
- `.tool-versions`
- `package.json`
- `Dockerfile`

If you don't have that version of node installed:

- `nvm install v22.13.1`
- `nvm alias default v22.13.1`

You may also need to update yarn on your new node version:

- `npm upgrade --global yarn`
- `yarn install`
