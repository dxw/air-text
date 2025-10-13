## Updating the Node version

To update the Node version, update the version number in the following files:

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

You may also need to update yarn on your new Node version:

```bash
  npm upgrade yarn
  yarn install
```
