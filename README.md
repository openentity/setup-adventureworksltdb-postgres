# Setup Postgres AdventureWorksLT Database Action

This GitHub action automatically installs a PostgresSql and `adventureworkslt` database on Windows for testing.

On Linux, use docker image directly: https://github.com/openentity/adventureworksltdb

## Usage

### Inputs

| Key              | Value                                                                                    | Default     |
|------------------|------------------------------------------------------------------------------------------|-------------|
| username         | The username of the user to setup.                                                       | `admin`     |
| password         | The password of the user to setup.                                                       | required    |
| postgres-version | The PostgreSQL major version to install. Supported values: "14", "15", "16", "17", "18". | `18`        |

### Example

```yaml
name: Continuous Integration

on:
  pull_request:
  push:
  schedule:
    - cron: "30 8 * * 1"

jobs:
  test:
    name: Tests
    runs-on: windows-latest
    steps:

      - name: Setup Postgres AdventureWorksLT Database
        uses: openentity/setup-mssql@v1
        with:
          password: "iamastrongpassword1234!"
```

## License

The scripts and documentation in this project are released under the MIT License.
