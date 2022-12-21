eval $(op signin)
export AWS_ACCESS_KEY_ID=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields AWS_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields AWS_SECRET_ACCESS_KEY)
export AWS_REGION=us-east-2
export GITHUB_OAUTH_TOKEN=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields GITHUB_OAUTH_TOKEN)
export QUAY_USERNAME=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields QUAY_USERNAME)
export QUAY_PASSWORD=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields QUAY_PASSWORD)
export RHSM_USERNAME=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields RHSM_USERNAME)
export RHSM_PASSWORD=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields RHSM_PASSWORD)
export DB_USERNAME=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields DB_USERNAME)
export DB_PASSWORD=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields DB_PASSWORD)
export POOL_ID=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields POOL_ID)
export WIN_INITIAL_PASSWORD=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields WIN_INITIAL_PASSWORD)
export CONTROLLER_HOST=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields CONTROLLER_HOST)
export CONTROLLER_OAUTH_TOKEN=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields CONTROLLER_OAUTH_TOKEN)
export AAP_USERNAME=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields AAP_USERNAME)
export AAP_PASSWORD=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields AAP_PASSWORD)
export RH_REGISTRY_USERNAME=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields RH_REGISTRY_USERNAME)
export RH_REGISTRY_PASSWORD=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields RH_REGISTRY_PASSWORD)
export RH_OFFLINE_TOKEN=$(op item get bvpntj5tevsm32d6kn4kxxb62a --fields RH_OFFLINE_TOKEN)
export NS=viper
export LOGIC_REPO=${HOME}/rhdirt
#If you don't have an ssh-agent running
#eval $(ssh-agent)
aws ssm get-parameter --name "/${NS}/machine_ssh_private_key" --with-decryption --output text --query Parameter.Value | ssh-add -
