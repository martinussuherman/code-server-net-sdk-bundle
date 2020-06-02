# code-server-net-sdk-bundle
Code Server with Net Core SDK bundled

---

## What is this image for ?

This is a [.NET Core SDK 3.1 - Ubuntu 18.04](https://hub.docker.com/_/microsoft-dotnet-core-sdk/) based image bundled with [code-server](https://github.com/cdr/code-server/). It enables one to run [VS Code](https://code.visualstudio.com/) for developing .NET Core 3.1 application in the browser with [Omnisharp](https://github.com/OmniSharp/omnisharp-roslyn) support.

## Why use this image?

*code-server* service on this container will run as `non-root` (`vscode`) user. This add an extra layer of security and are generally recommended for production environments. This container also allow mapping of the `user id` dan `group id` of the user running docker to `vscode` user and group, which will enable the use of more restrictive file permission.

## How to use this image?

### *Using docker run*

```bash
$ docker run --name code-server -v ~/path/for/vscode-and-nuget:/home/vscode -e TZ=Asia/Jakarta -e EUID=$(id -u) -e EGID=$(id -g) martinussuherman/code-server-net-sdk-bundle
```
This will set the `timezone` to Asia/Jakarta (you will want to change it to your own timezone) and map the `user id` dan `group id` of the current user to `vscode` user and group.

### *Using docker-compose*

```yaml
version: '3'

services:
  code-server:
    image: martinussuherman/code-server-net-sdk-bundle
    environment:
      - TZ=Asia/Jakarta
      - EUID=1001
      - EGID=1001
    volumes:
      - ~/path/for/vscode-and-nuget:/home/vscode
```

*Note:* you will want to change the value for `EUID` and `EGID` with your current user `user id` dan `group id`.
