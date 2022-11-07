To fix this:

1.) Navigate to Keycloak Operator or the Keycloak Admin console
2.) Navigate to OpenShift Realm
3.) If in Keycloak Admin Console, change the the redirect URI to "dragonslair" instead of "typo"
4.) If attempting to update the KeyCloakRealm CRD via the Operator, note that unfortunately, updating the redirect uri in the CRD will not reconcile a change. The Keycloak Realm config should be saved then re-created with the correct redirect uri for the update to reconcile