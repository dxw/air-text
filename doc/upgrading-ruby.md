## Updating the Ruby version

To upgrade Ruby, update the version number in the following files:

- `.ruby-version`
- `.tool-versions`
- `Gemfile`
- `Dockerfile`

Then run `bundle install` to update the gems and lockfile.

### Installing the new Ruby version with `rbenv`

If you don't have that version of Ruby installed, you can use `rbenv` to install it:

```bash
rbenv install v3.4.7
```