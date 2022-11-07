### To fix OAuth break:

1. Login to cluster with Kubeadmin

2. Navigate to Keycloak Operator or the Keycloak Admin console (credentials may be found in the sso namespace -> Secrets -> credential-{{managed_cluster_name}}-keycloak )

3. Navigate to OpenShift Realm

4. If in Keycloak Admin Console, change the the redirect URI to "dragonslair" instead of "typo"

5. If attempting to update the KeyCloakRealm CRD via the Operator, note that unfortunately, updating the redirect uri in the CRD will not reconcile a change. The Keycloak Realm config should be saved then re-created with the correct redirect uri for the update to reconcile