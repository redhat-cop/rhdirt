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

## Creating base images
I adopted the base container images from registry.redhat.io, but the builder image would fail out of the box by trying to update the openshift-clients.  Both prepend and append steps happen within the final stage of the image build making it difficult to shim a package install earlier in the process.  The base image could be skipped and have the openshift-clients package updated out of band, but both are available with similar microdnf fixes.

1. Enter the base image directory and run a container build from there.  Change your tag to reflect your target container registry.
```
podman build -t quay.io/hfenner/base-image
```

2. Switch to the builder image directory and repeat.  Change your tag to reflect your target container registry.
```
podman build -t quay.io/hfenner/builder-image
```

3. Push both images.
```
podman push quay.io/hfenner/builder-image
podman push quay.io/hfenner/base-image
```

#Clear all generated images and exited containers
If you find yourself building a lot, you may start to run out of space due to the sheer number of containers created.  This command is a nuclear option to clear them all; use with caution!
```
podman rmi $(podman images -qa) -f
```
