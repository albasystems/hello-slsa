# Demo 2 : Generate the provenance using a trusted builder

1 - Edit the Dockerfile and commit

2 - Explore the ``hello-slsa`` and the ``slsa-provenance-generator`` repos.

3 - Verify the attestation : 
````shell
IMAGE=ghcr.io/albasystems/hello-slsa:main

IDENTITY="https://github.com/albasystems/slsa-provenance-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v1.5.0"

cosign verify-attestation --type slsaprovenance  \
    --certificate-identity $IDENTITY \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
    --policy policies/policy.cue $IMAGE \
    | jq .
````

4 - (Optional) Display the attestation : 
````shell
cosign verify-attestation --type slsaprovenance  \
    --certificate-identity $IDENTITY \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
    --policy policies/policy.cue $IMAGE \
    | jq .payload -r | base64 -d | jq .
````
