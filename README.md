![Testing Status](https://github.com/repaction/uploader/workflows/Testing%20uploader/badge.svg)
---

# Cloud Uploader Action

This github action simply upload a file to cloud. Now only uploading
to dropbox has been implemented.

## Usage

1. Create a dropbox app

The user should create dropbox app before using this uploader. One can
go to <https://www.dropbox.com/developers/apps> to create the app and
obtain an access token.

2. Setup encrypted token

In the github settings page of your personal or organization profile,
go to "Secretes" to add a variable named `DROPBOX_TOKEN` with values
obtained from the dropbox app.

3. Configure github action

Add a github action file to your repository under `.github/workflows`
with the following example configuration.

``` yaml
name: Testing uploader

jobs:
  testing:
    runs-on: ubuntu-latest
    steps:
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2
      - name: Upload README
        uses: repaction/uploader@main
        env:
          DROPBOX_TOKEN: ${{ secrets.DROPBOX_TOKEN }}
        with:
          src_file: README.md
          dst_file: /devel/README.md
```
