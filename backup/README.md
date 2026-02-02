# S3 Backup Script

Backup a specified directory to an S3 bucket (Cloudflare R2) and logs the process.
> This uses aws cli. Please have that configured with access tokens

- Creates a `.tar.gz` archive of the source directory.
- Uploads the archive to a specified S3 bucket.
- Logs success and warnings to `/var/log/backup.log`.
- Cleans up temporary backup files after upload.

```bash
S3_BUCKET="your-bucket-name"
SOURCE_DIR="./directory-to-backup"
R2_ENDPOINT="https://<your-r2-endpoint>/"
AWS_PROFILE="default"
````
<img width="1213" height="613" alt="image" src="https://github.com/user-attachments/assets/d9085e4e-5ba7-4b5b-a80d-042b1d1b35ba" />
