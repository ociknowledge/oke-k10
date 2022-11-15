echo '-------Deploying Kasten K10 and NGIX'
starttime=$(date +%s)
. ./setenv.sh

echo '-------Change StorageClass'
kubectl patch storageClass oci -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl patch storageClass oci-bv -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageClass oci -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageClass oci-bv -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

echo '-------Install K10'
kubectl create ns kasten-io
helm repo add kasten https://charts.kasten.io
helm repo update

#For Production, remove the lines ending with =1Gi from helm install
#For Production, remove the lines ending with airgap from helm install
helm install k10 kasten/k10 --namespace=kasten-io \
    --set externalGateway.create=true \
    --set auth.basicAuth.enabled=true \
    --set auth.basicAuth.htpasswd='ocik10:{SHA}geW18mxWpmbYzOXIoTI496D7UV4=' \
    --set global.persistence.metering.size=1Gi \
    --set prometheus.server.persistentVolume.size=1Gi \
    --set global.persistence.catalog.size=1Gi \
    --set global.persistence.jobs.size=1Gi \
    --set global.persistence.logging.size=1Gi \
    --set global.persistence.grafana.size=1Gi \
    --set metering.mode=airgap 

echo '-------Set the default ns to k10'
kubectl config set-context --current --namespace kasten-io

echo '-------Deploying a NGIX Base'
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: nginx-example-base
  labels:
    app: nginx

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: nginx-example-base
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.17.6
        name: nginx
        ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx
  name: my-nginx
  namespace: nginx-example-base
spec:
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: nginx
  type: LoadBalancer
EOF


echo '-------Wait for 1 or 5 mins for the Web UI IP and token'
kubectl wait --for=condition=ready --timeout=300s -n kasten-io pod -l component=jobs

echo '-------Waiting for K10 services are up running in about 1 or 5 mins'
kubectl wait --for=condition=ready --timeout=300s -n kasten-io pod -l component=catalog

#Create an OCI Object Storage location profile
./oci-s3-location.sh

k10ui=http://$(kubectl get svc gateway-ext -n kasten-io | awk '{print $4}' | grep -v EXTERNAL)/k10/#

echo '-------Accessing K10 UI'
echo '$k10ui'

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time for K10 deployment is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Modified by Ruthford Jay"
echo "-------Email me if any suggestions or issues ruthford.jay@oracle.com"
echo "" | awk '{print $1}'