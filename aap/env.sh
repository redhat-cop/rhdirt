#Sign in to One Password if necessary
eval $(op signin)
export AWS_ACCESS_KEY_ID=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields username)
export AWS_SECRET_ACCESS_KEY=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields credential)
export AWS_REGION=us-east-2
export NS=viper
export LOGIC_REPO=${HOME}/rhdirt
export POOL_ID=$(op item get laep4gvegwlsuzdalnfkqxsumi --fields POOL_ID)
export RHSM_USERNAME=$(op item get laep4gvegwlsuzdalnfkqxsumi --fields username)
export RHSM_PASSWORD=$(op item get laep4gvegwlsuzdalnfkqxsumi --fields password)
export WIN_INITIAL_PASSWORD=$(op item get qwhf7kkui42bo62k2ckocoatyu --fields windows_initial_password)
export CONTROLLER_OAUTH_TOKEN=$(op item get djqax5szekil4unby5fownb4qa --fields password)
export CONTROLLER_HOST=$(op item get djqax5szekil4unby5fownb4qa --fields controller_host)
export GITHUB_OAUTH_TOKEN=$(op item get cuxcpxsvbj7hkab62dgngjqvnu --fields password)
export DB_USERNAME=$(op item get qwhf7kkui42bo62k2ckocoatyu --fields username)
export DB_PASSWORD=$(op item get qwhf7kkui42bo62k2ckocoatyu --fields password)
export RH_REGISTRY_USERNAME=$(op item get op7albvuwg6vuzhuwreohhxbyu --fields username)
export RH_REGISTRY_PASSWORD=$(op item get op7albvuwg6vuzhuwreohhxbyu --fields password)
export RH_REGISTRY_URL=$(op item get op7albvuwg6vuzhuwreohhxbyu --fields registry_url)
#If you don't have an ssh-agent running
#eval $(ssh-agent)
aws ssm get-parameter --name "/${NS}/machine_ssh_private_key" --with-decryption --output text --query Parameter.Value | ssh-add -
