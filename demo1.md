# Demo 1 : Sigstore


1 - Edit the Dockerfile commit and push (the push will trigger the build, we will use the results in demo 2)

2 - Create container image
````shell
IMAGE=ghcr.io/albasystems/hello-slsa:manual

docker build -t $IMAGE   .
````

3 - Run the container 
````shell
docker run $IMAGE
````

4 - Push the image

````shell
Docker push $IMAGE
````

5 - Update the image name with the image's digest : We need this because we want to sign an immutable image.

````shell
IMAGE=$(docker inspect --format='{{index .RepoDigests 0}}' $IMAGE)

echo $IMAGE
````

6 - Sign the image
````shell
cosign sign $IMAGE
````

7 - Verify the signature
````shell
cosign verify $IMAGE  --certificate-identity abdennebi.dev@gmail.com --certificate-oidc-issuer "https://github.com/login/oauth" | jq .
````

8 - Check the rekor entry, go to https://rekor.tlog.dev/?logIndex=$log_index
````shell
log_index=$(cosign verify $IMAGE  --certificate-identity abdennebi.dev@gmail.com --certificate-oidc-issuer "https://github.com/login/oauth" -o json | jq '.[-1].optional.Bundle.Payload.logIndex')``

echo $log_index
````
or 
````shell
rekor-cli get --format json --log-index $logIndex | jq .
````

