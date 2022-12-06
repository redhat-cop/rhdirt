# Creating an execution environment
We'll need to pull some collections from an authenticated source (Red Hat Automation Hub).

## Creating ansible.cfg to support authentication
1. Export your hub token, URL, and SSO URL.  They can be found here: https://cloud.redhat.com/ansible/automation-hub/token/
```
export HUB_URL=<your hub URL>
export HUB_SSO_URL=<your HUB SSO URL>
export HUB_TOKEN=<your hub token>
```
2. Run envsubst command to create ansible.cfg for hub authentication
```
envsubst < ansible.cfg.envsubt > ansible.cfg
```
3. Create the image with ansible-builder.  Tag appropriately, this one will get sent to quay.io in the hfenner namespace.
```
ansible-builder build -t quay.io/hfenner/dirt -v3
```
4. Push your image (you may have to log in first to container registry)
```
podman push quay.io/hfenner/dirt
```
