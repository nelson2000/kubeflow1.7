

kustomize build common/cert-manager/cert-manager/base | kubectl apply -f -
kubectl wait --for=condition=ready pod -l 'app in (cert-manager,webhook)' --timeout=180s -n cert-manager
kustomize build common/cert-manager/kubeflow-issuer/base | kubectl apply -f -



kustomize build common/istio-1-16/istio-crds/base | kubectl apply -f -
kustomize build common/istio-1-16/istio-namespace/base | kubectl apply -f -
kustomize build common/istio-1-16/istio-install/base | kubectl apply -f -



kustomize build common/dex/overlays/istio | kubectl apply -f -


kustomize build common/oidc-authservice/base | kubectl apply -f -


kustomize build common/knative/knative-serving/overlays/gateways | kubectl apply -f -
kustomize build common/istio-1-16/cluster-local-gateway/base | kubectl apply -f -


kustomize build common/knative/knative-eventing/base | kubectl apply -f -

kustomize build common/kubeflow-namespace/base | kubectl apply -f -

# Kubeflow Roles

kustomize build common/kubeflow-roles/base | kubectl apply -f -

# Install istio resources:
kustomize build common/istio-1-16/kubeflow-istio-resources/base | kubectl apply -f -
# Kubeflow Pipelines

kustomize build apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user | awk '!/well-defined/' | kubectl apply -f -

kustomize build contrib/kserve/kserve | kubectl apply -f -

# Install the Models web app:

kustomize build contrib/kserve/models-web-app/overlays/kubeflow | kubectl apply -f -
# 
# Katib
# Install the Katib official Kubeflow component:

kustomize build apps/katib/upstream/installs/katib-with-kubeflow | kubectl apply -f -

# Central Dashboard
# Install the Central Dashboard official Kubeflow component:
kustomize build apps/centraldashboard/upstream/overlays/kserve | kubectl apply -f -

# Admission Webhook
# Install the Admission Webhook for PodDefaults:

kustomize build apps/admission-webhook/upstream/overlays/cert-manager | kubectl apply -f -
# Notebooks
# Install the Notebook Controller official Kubeflow component:

kustomize build apps/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl apply -f -
# Install the Jupyter Web App official Kubeflow component:

kustomize build apps/jupyter/jupyter-web-app/upstream/overlays/istio | kubectl apply -f -
# Profiles + KFAM
# Install the Profile Controller and the Kubeflow Access-Management (KFAM) official Kubeflow components:

kustomize build apps/profiles/upstream/overlays/kubeflow | kubectl apply -f -

# Volumes Web App

# Install the Volumes Web App official Kubeflow component:

kustomize build apps/volumes-web-app/upstream/overlays/istio | kubectl apply -f -
# 

# #Tensorboard
# Install the Tensorboards Web App official Kubeflow component:

kustomize build apps/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl apply -f -
# Install the Tensorboard Controller official Kubeflow component:

kustomize build apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow | kubectl apply -f -
# Training Operator
# Install the Training Operator official Kubeflow component:

kustomize build apps/training-operator/upstream/overlays/kubeflow | kubectl apply -f -
# User Namespace
# Finally, create a new namespace for the the default user (named kubeflow-user-example-com).

kustomize build common/user-namespace/base | kubectl apply -f -
