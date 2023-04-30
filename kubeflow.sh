#########################
# kubeflow installation #
#########################

#Install cert-manager: 
kustomize build namespaces/base | kubectl apply -f -
kustomize build common/cert-manager/cert-manager/base | kubectl apply -f -
kubectl wait --for=condition=ready pod -l 'app in (cert-manager,webhook)' --timeout=180s -n cert-manager
kustomize build common/cert-manager/kubeflow-issuer/base | kubectl apply -f -

# Istio

kustomize build common/istio-1-16/istio-crds/base | kubectl apply -f -
kustomize build common/istio-1-16/istio-namespace/base | kubectl apply -f -
kustomize build common/istio-1-16/istio-install/base | kubectl apply -f -

#Dex

kustomize build common/dex/overlays/istio | kubectl apply -f -
kustomize build common/oidc-authservice/base | kubectl apply -f -


#Knative

kustomize build common/knative/knative-serving/overlays/gateways | kubectl apply -f -
kustomize build common/istio-1-16/cluster-local-gateway/base | kubectl apply -f -


#Knative Eventing
kustomize build common/knative/knative-eventing/base | kubectl apply -f -

#Kubeflow Namespace
kustomize build common/kubeflow-namespace/base | kubectl apply -f -

#kubeflow roles
kustomize build common/kubeflow-roles/base | kubectl apply -f -

#kubeflow Istio resource
kustomize build common/istio-1-16/kubeflow-istio-resources/base | kubectl apply -f -


#Istio Resource
kustomize build common/istio-1-16/kubeflow-istio-resources/base | kubectl apply -f -


#Kubeflow Pipeline Multi-User

kustomize build apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user | kubectl apply -f -

#Do not use pns
#kustomize build apps/pipeline/upstream/env/platform-agnostic-multi-user-pns | kubectl apply -f -


kustomize build apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user | kubectl apply -f -

#Do not use pns
#kustomize build apps/pipeline/upstream/env/platform-agnostic-multi-user-pns | kubectl apply -f -

#KServe Component
kustomize build contrib/kserve/kserve | kubectl apply -f -

#Models WebApp
kustomize build contrib/kserve/models-web-app/overlays/kubeflow | kubectl apply -f -

#Katib
kustomize build apps/katib/upstream/installs/katib-with-kubeflow | kubectl apply -f -


#Central Dashboard
kustomize build apps/centraldashboard/upstream/overlays/kserve | kubectl apply -f -


#Admission Hook
kustomize build apps/admission-webhook/upstream/overlays/cert-manager | kubectl apply -f -

#Notebooks
kustomize build apps/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl apply -f -

#Jupiter webapp 
kustomize build apps/jupyter/jupyter-web-app/upstream/overlays/istio | kubectl apply -f -

#Profiles + KFAM
kustomize build apps/profiles/upstream/overlays/kubeflow | kubectl apply -f -

#Volumes Web App
kustomize build apps/volumes-web-app/upstream/overlays/istio | kubectl apply -f -

# Tensor board
kustomize build apps/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl apply -f -

# Tensor board controller
kustomize build apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow | kubectl apply -f -


# Training Operator
kustomize build apps/training-operator/upstream/overlays/kubeflow | kubectl apply -f -


#User namespace
kustomize build common/user-namespace/base | kubectl apply -f -


# kubectl get pods -n cert-manager
# kubectl get pods -n istio-system
# kubectl get pods -n auth
# kubectl get pods -n knative-eventing
# kubectl get pods -n knative-serving
# kubectl get pods -n kubeflow
# kubectl get pods -n kubeflow-user-example-com


#  kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

# kubectl patch service -n istio-system istio-ingressgateway -p '{"spec": {"type": "LoadBalancer"}}'


# kubectl get svc -n istio-system istio-ingressgateway -o jsonpath='{.status.LoadBalancer.ingress[0]}'