# AAP Test Environment
This deploys AAP in a single node configuration on AWS.  The code is run from a RHEL 9 server using ansible-navigator.

## Quick Start
1.) Set the following environment variables and SSH key.  You can also run `source env.sh`.
```
#This is an example lookup from One Password, you can also set it directly
export AWS_ACCESS_KEY_ID=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields username)
#This is an example lookup from One Password, you can also set it directly
export AWS_SECRET_ACCESS_KEY=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields credential)
#Use the AWS region you need
export AWS_REGION=us-east-2
#Change namespace as appropriate
export NS=viper
#Change repo 
export REPO=${HOME}/rhdirt
#Skip vault variables as we won't need them for this
#You may have these set from the seeding
unset ANSIBLE_VAULT_PASSWORD_FILE
unset ANSIBLE_VAULT_PASSWORD
#Start SSH agent if necessary
eval $(ssh-agent)
#Add SSH key
aws ssm get-parameter --name "/${NS}/ssh_private_key" --with-decryption --output text --query Parameter.Value | ssh-add -
```

2.) Deploy the EC2 instances
```
ansible-navigator
```


## Helpful commands
```
#Specify which Ansible Navigator config to use at a global level
export ANSIBLE_NAVIGATOR_CONFIG=${REPO}/aap/ansible-navigator.yml
#Specify which Ansible Navigator config to use just for this run
#ansible-navigator.yml is a default filename, but this can help if
#you're not in the directory
ANSIBLE_NAVIGATOR_CONFIG=${REPO}/aap/ansible-navigator.yml ansible-navigator
#Configure flags for ansible-navigator
export ANSIBLE_NAVIGATOR_CMDLINE='-e state=absent -e instance_state=absent'
```
