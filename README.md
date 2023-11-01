# Summary

This project is designed and built for the assignment I have been assigned to during the hiring process.
The idea of this project is to design a Ruby on Rails application that provides APIs to store and retrieve objects/files using an id, name or a path.

Think of this project as developing a simple object storage system that provides a single interface for multiple storage backends choices, such as:
- AWS S3 bucket
- Local storage, the directory path is `<RAILS_ROOT>/file_storage/local_storage/`
- Database table

Based on some configuration -in this case from queryParams- set the storage service.

# For the technical details:

- Ruby version -> 2.6.5
- Rails version ->  6.1.7.6

Once you clone this repositiry do these commands:
For simple purpos, I set Postgresql user named as the defaulf one `postgres` to avoid permission issues

```sh
cd simple-drive-project
bundle install
rails db:create
rails s
```
✨ The application should be running on `localhost:3000`✨


To use the application you need to sign in by sending
`POST  /v1/user_token`

Body should have password -for simple pupose only-
```
{
  "password": "password"
}
```
Then you will get response of the token
```
{
  "auth_token": "eyJhbGciOiJub25lIn0.eyJkYXRhIjoicGFzc3dvcmQifQ."
}
```
***This token should be used as `Bearer` token for the other features.***


# Storing a Blob of Data

To send the file(`for simple pupose - I assumed this file is image/png format`) use this endpoint `POST  /v1/blobs`

Optionally you can set the service type as queryParam -for simple purpose-, if it is not sent, then by defailt it will be to `local`
`POST  /v1/blobs?storage_type=local`

Services types keys:
- `local`
- `s3`
- `database`

Others are not supported

Request body:
```
{
  "blob_id": "your-file-id",
  "data": "your-encoded-Base64-file"
}
```


Response:
```
{
  "blob_id": "your-file-id",
  "image": {
      "file": "your-encoded-Base64-file"
      },
  "size": 4208,
  "created_at": "2023-10-31T11:59:12.819Z"
}
```

# Retrieving a Blob

To retrieve the file use this endpoint `GET  /v1/blobs/:id`

Response:
```
{
  "blob_id": "your-file-id",
  "image": {
      "file": "your-encoded-Base64-file"
      },
  "size": 4208,
  "created_at": "2023-10-31T11:59:12.819Z"
}
```
