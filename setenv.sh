#-------Set the environment variables"
export MY_CLUSTER=OCI_Cluster_K10            #Customize your cluster name
# https://aws.amazon.com/es/ec2/instance-types/
export MY_INSTANCE_TYPE=t3a.2xlarge          #Customize your favorite machine type
# https://docs.oracle.com/es-ww/iaas/nosql-database/doc/data-regions-and-associated-service-urls.html
export OCI_MY_REGION=us-ashburn-1            #Customize your favorite region
# https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
export MY_ZONE=us-east-2c                    #Customize your favorite zone
export OCI_MY_BUCKET=k10                     #Customize your favorite bucket
export OCI_MY_BUCKET_URI=idnygso6gagh.compat.objectstorage.us-ashburn-1.oraclecloud.com
export OCI_MY_OBJECT_STORAGE_PROFILE=oci-os1 #Customize your favorite profile name
export MY_K8S_VERSION=1.22                   #Customize your Kubernetes Version
source ~/.bashrc                    #Set environment variables
