## Updating the Node version

To update the Node version, update the version number in the following files (usually you can just do a find-and-replace globally):

- `.node-version`
- `.tool-versions`
- `package.json`
- `Dockerfile`

### Installing the new Node version with `nvm`
If you don't have that version of Node installed, you can use `nvm` (Node Version Manager) to install it:

```bash
nvm install v22.13.1
```

Then set it as the default version:

```bash
nvm alias default v22.13.1
```

You may need to update yarn on your new Node version:

```bash
  npm upgrade yarn -g
```

Update the Yarn files:

```bash
yarn install
```