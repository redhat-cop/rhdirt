#Find the project ID by name then update project while following progress
awx project update $(awx project list --name viper_rhdirt | jq '.results[0].id') --monitor -f human
#Find the inventory source ID by name then update inventory source while following progress
awx inventory_sources update $(awx inventory_sources list --name 'viper Inventory Source' | jq .results[0].id) - monitor -f human
#Find current SCM revision on server
awx project get $(awx project list --name viper_rhdirt | jq '.results[0].id') | jq .scm_revision
#Check SCM revision of most recent commit in project to compare
git log -n1 
#Get list of running jobs
awx jobs list --status running 
#Launch job template and follow results
awx job_template launch $(awx job_templates list --name 'viper ec2_rds' | jq .results[0].id) --monitor -f human
#Check for pending jobs
awx jobs list --status pending
#Check for running jobs
awx jobs list --status running
#Grab running job output
awx jobs monitor $(awx jobs list --status running | jq '.results[0].id')
#Select last job run id
awx jobs list --name viper_ec2_rds | jq '.results | sort_by(.finished)[-1].id'
