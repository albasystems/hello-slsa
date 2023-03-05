# Demo 3 : Binary authorization with Kyverno

In this demo we check that the pod's image is signed and has a signed provenance.

1 - Install Kyverno
```shell
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm install kyverno kyverno/kyverno -n kyverno --create-namespace --set replicaCount=1
```

2 - Deploy the ``manual`` and the ``trusted`` pods
````shell
kubectl apply -f manifests/manual-pod.yaml
kubectl apply -f manifests/trusted-pod.yaml
````

3 - Delete the pods
````shell
kubectl delete pods hello-slsa hello-slsa-manual
````

4 - Deploy the Kyverno provenance verification policy
```shell
kubectl apply -f policies/provenance-verify.yaml
```

5 - Redeploy the ``manual`` and the ``trusted`` pods
````shell
kubectl apply -f manifests/manual-pod.yaml
kubectl apply -f manifests/trusted-pod.yaml
````

The ``manual`` will fail to deploy because it doesn't have a provenance.

**Optional**

6 - Delete the Kyverno provenance policy, delete also the ``hello-slsa`` pod
```shell
kubectl delete cpol verify-slsa-provenance 
kubectl delete pods hello-slsa 
``` 

7 - Deploy the Kyverno signature verification policy
```shell
kubectl apply -f policies/signature-verify.yaml
```

8 - Redeploy the ``manual`` and the ``trusted`` pods
````shell
kubectl apply -f manifests/manual-pod.yaml
kubectl apply -f manifests/trusted-pod.yaml
````

The ``manual`` will fail to deploy because it has been signed locally.





