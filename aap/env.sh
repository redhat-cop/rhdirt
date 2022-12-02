#Sign in to One Password if necessary
#eval $(op sigin)
export AWS_ACCESS_KEY_ID=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields username)
export AWS_SECRET_ACCESS_KEY=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields credential)
export AWS_REGION=us-east-2
export NS=viper
export REPO=${HOME}/rhdirt
unset ANSIBLE_VAULT_PASSWORD_FILE
unset ANSIBLE_VAULT_PASSWORD
eval $(ssh-agent)
aws ssm get-parameter --name "/${NS}/ssh_private_key" --with-decryption --output text --query Parameter.Value | ssh-add -
