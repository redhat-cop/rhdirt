#Sign in to One Password if necessary
eval $(op signin)
export AWS_ACCESS_KEY_ID=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields username)
export AWS_SECRET_ACCESS_KEY=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields credential)
export AWS_REGION=us-east-2
export NS=viper
export LOGIC_REPO=${HOME}/rhdirt
#If you don't have an ssh-agent running
#eval $(ssh-agent)
aws ssm get-parameter --name "/${NS}/machine_ssh_private_key" --with-decryption --output text --query Parameter.Value | ssh-add -
