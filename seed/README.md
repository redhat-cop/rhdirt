# Seeding a New Lab Environment
Keeping your secrets in an encrypted file such as one created with Ansible Vault is a great way to get started.  There are some limitations to this practice.  

One risk is committing the encrypted file to a publicly accessible location such as Github.  The file itself is not inherently vulnerable, but in the event of an compromised encryption key (either through an accidental commit or other means), the encrypted file is easily accessed.  Even if the encryption key is outdate, an attacker could walk the commit history and potentially recover secrets that haven't yet been rotated or determine a password pattern they could use to compromise additional systems.

Another challenge is potentially inconsistent secret files.  One system might change values but not yet have the updated file committed to source control.  Another system might be actively working with the lab and become locked out as a result.

A secrets manager can help with both of these challenges.  Each parameter can have independent RBAC controls and will typically retain a change history in the event that historical values become important.  Additionally, it's typically centrally placed and the value isn't committed to the main code repository, but rather the query to obtain the value provided the proper access credentials are in place.

In the case of lab building with AWS, AWS Parameter Store is a AWS service that has production level support while providing up to 10,000 parameters (encrypted or otherwise) for free.  As labs often don't enjoy the same operational support level that production systems do, a cheap or free production service is very valuable.  

It's somewhat cumbersome to enter values into Parameter Store through the web GUI, and it's likely that a lab would need to be loaded on more than one AWS account.  To make it easier to seed, copy this directory to a private git repository and follow the quickstart guidance below to easiy seed the environment to your target AWS account.

## Quick Start
We're going to namespace our deployment for simplicity.  This will make it possible to easily spin up multiple environments in parallel.

For this tutorial, our namespace will be `viper`.  You can choose another name and simply substitute references as appropriate.  We recommend https://randomwordgenerator.com/ for inspiration such as "loud ant".

1.) You'll need to install ansible-navigator and the AWS command line.  
AWS Command Line - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#cliv2-linux-install  
ansible-navigator - https://ansible-navigator.readthedocs.io/en/latest/installation/  

2.) Export your AWS environment variables.  You could also keep this in a config file, but note that this guidance will expect them in environment variables and you'll need to adapt accordingly.  You can simply write the actual value in, but we recommend a password manager that can be used from the CLI and using bash command subsitution to prevent any missteps with accidentally committing a secret.  The example below uses 1Password.  We use AWS Parameter Store throughout the remainder of this guidance as a secrets manager, but we need to establish our initial access.  Command substitution makes this process both faster and safer.  We also include an AWS region as most AWS interactions require you specify it.  Change as appropriate for your region.
```
export AWS_ACCESS_KEY_ID=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields username)
export AWS_SECRET_ACCESS_KEY=$(op item get mq6tv6iavgezhk7foykfl6yvuy --fields credential)
export AWS_REGION=us-east-2
```

2.) Create (or edit) an ansible vault file with your environment name. Initially seed this with your vault password (yes, put your vault password into this file.  We're going to inject it into AWS Parameter Store and use command substition later on to make it simpler to use.  You can also set the `ANSIBLE_VAULT_PASSWORD` environment variable directly or store it in AWS Parameter Store then use command substitution to maintain it.
```
#Create
ansible-navigator exec -- ansible-vault create viper.yml
#Edit
ansible-navigator exec -- ansible-vault edit viper.yml
#Inject the Vault password to AWS before running the playbook.
#read -s will allow you to type (or paste) the vault password without exposing in to the terminal 
read -s ANSIBLE_VAULT_PASSWORD
#Export the password environment variable to make sure any subshell processes you run can read it
export ANSIBLE_VAULT_PASSWORD
#Import the parameter to AWS Parameter Store
aws ssm put-parameter --name "/viper/ansible_vault_password" --type "SecureString" --value "${ANSIBLE_VAULT_PASSWORD}" --overwrite
#Set ANSIBLE_VAULT_PASSWORD to a command substitution rather than a string.  If you want to be super sure you did this right, you can unset the current value,
#echo it to make sure you get an empty string back, set it with the command substitution, and echo it to make sure you get the password back
#Unset the environment variable
unset ANSIBLE_VAULT_PASSWORD
#Echo to make sure that the environment variable doesn't still have a value
echo $ANSIBLE_VAULT PASSWORD
#Pull the environment variable from Parameter Store
export ANSIBLE_VAULT_PASSWORD=$(aws ssm get-parameter --name "/viper/ansible_vault_password" --with-decryption --output text --query Parameter.Value)
#Echo to make sure that the environment variable returns the vault password
echo $ANSIBLE_VAULT PASSWORD
```

3.) Set the following environment variables.
```
#Identify top level directory of repo so ansible navigator config file works as expected
export REPO=${HOME}/viper
#Export path to script that will echo out our environment variables 
export ANSIBLE_VAULT_PASSWORD_FILE=${REPO}/vault.sh
```

4.) Once the system is established, you can modify the example `env.sh` script in this repository to reflect your environment.  Simple source the file like below to quickly update the system.
```
source ${REPO}/env.sh
```

5.) Seed the system.  There is an ansible-navigator.yml configuration file located in this directory that should automatically run the proper playbook.  The ANSIBLE_NAVIGATOR_CONFIG environment variable can also be configured with the path to this file if it becomes necessary to run `ansible-navigator` from other directories.
```
ansible-navigator
```
