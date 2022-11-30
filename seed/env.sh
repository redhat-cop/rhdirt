export AWS_ACCESS_KEY_ID=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields username)
export AWS_SECRET_ACCESS_KEY=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields credential)
export AWS_REGION=us-east-2
export REPO=${HOME}/viper
export ANSIBLE_VAULT_PASSWORD_FILE=${REPO}/vault.sh
export ANSIBLE_VAULT_PASSWORD=$(aws ssm get-parameter --name "/viper/ansible_vault_password" --with-decryption --output text --query Parameter.Value)
