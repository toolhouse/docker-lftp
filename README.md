# Docker LFTP

Upload/download files to a remote server via Docker.

## Status

This is an early release and is not stable. There will almost certainly be 
breaking changes in the future.

## Usage

This image is intended to be used via the `docker run` command to upload or
download files to/from a remote server.

### Commands

The following commands are available for use with `docker run`:

|   Command   |                              Description                              |
|-------------|-----------------------------------------------------------------------|
| `/download` | Recursively downloads a file or directory **from** the remote server. |
| `/upload`   | Recursively uploads a file or directory **to** the remote server.     |


### Volumes

There is a singe volume, `/files`, that is used for both uploads and downloads. 
When running the `/download` command this volume will be used to place the 
downloaded files. When running the `/upload` command the files in the volume
will be uploaded to the remote server.

### Environment Variables

The following environment variables are used for configuration:

|     Variable    |             Description             |        Example         |
|-----------------|-------------------------------------|------------------------|
| `REMOTE_SERVER` | The URL                             | sftp://ftp.example.com |
| `USERNAME`      | The username for the remote server. | kentclark              |
| `PASSWORD`      | The password for the remote server. | superman               |
| `REMOTE_PATH`   | The remote path                     | /home/kentclark/files  |


### Examples

#### Downloading

```shell
docker run --rm \
           --env REMOTE_SERVER="sftp://ftp.example.com" \
           --env USERNAME="kentclark" \
           --env PASSWORD="superman" \
           --env REMOTE_PATH="/remote/path/to/download" \
           --volume "/local/path/to/save/files":/files \
           toolhouse/lftp:v0.1.0 /download
```

#### Uploading

```shell
docker run --rm \
           --env REMOTE_SERVER="sftp://ftp.example.com" \
           --env USERNAME="kentclark" \
           --env PASSWORD="superman" \
           --env REMOTE_PATH="/remote/to/files" \
           --volume "/local/path/to/upload/files":/files \
           toolhouse/lftp:v0.1.0 /download
```