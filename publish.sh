# sync public/ dir to s3 bucket

options=("staging" "production" "quit")


# Display the options
echo "Please select an option:"
select opt in "${options[@]}"; do
  # Exit the loop if the user selects "Quit"
  if [[ $opt == "quit" ]]; then
    exit 1
    break
  fi

  if [[ $opt == "staging" ]]; then
    export BUCKET="darrenk.dev.staging"
    # break
  fi

  if [[ $opt == "production" ]]; then
  export BUCKET="darrenk.dev"
    # break
  fi

  # Print the selected option
  echo "You selected $opt"
  echo $BUCKET
  break
done

if [ -n "${BUCKET+x}" ]; then
  # VARNAME is defined
  # build the static files
  hugo

  # sync the public/ dir with s3 bucket excluding tagged files
  # aws s3 sync public/ s3://darrenk.dev.staging/ --region us-east-1 --delete --exclude "*.tf" --exclude "deployment/" --exclude "*.terraform" --exclude "*.terraform*"
  aws s3 sync public/ s3://$BUCKET/ --region us-east-1 --delete --exclude "*.tf" --exclude "deployment/" --exclude "*.terraform" --exclude "*.terraform*"
  echo $BUCKET
else
  # VARNAME is not defined
  echo "Run the script again and select a valid option.\n"
  exit 1
fi



