# sync public/ dir to s3 bucket

aws s3 sync public/ s3://darrenk.dev/ --region us-east-1 --delete --exclude "*.tf" --exclude "deployment/" --exclude "*.terraform" --exclude "*.terraform*"