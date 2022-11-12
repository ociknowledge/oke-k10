starttime=$(date +%s)
. ./setenv.sh
# TEMP_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
# FIRST2=$(echo -n $TEMP_PREFIX | head -c2)
# LAST2=$(echo -n $TEMP_PREFIX | tail -c2)
# OCP_GCP_MY_PREFIX=$(echo $FIRST2$LAST2)
# export AWS_ACCESS_KEY_ID=$(cat awsaccess | head -1 | sed -e 's/\"//g') 
# export AWS_SECRET_ACCESS_KEY=$(cat awsaccess | tail -1 | sed -e 's/\"//g')

echo '-------Deleting Postgresql and Kasten K10'

helm uninstall postgres -n root4j-postgresql
helm uninstall k10 -n kasten-io
kubectl delete ns root4j-postgresql
kubectl delete ns kasten-io

echo '-------Deleting objects from S3 Storage Bucket'
oci os object bulk-delete -bn $OCI_MY_BUCKET --force

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Modified by Ruthford Jay"
echo "-------Email me if any suggestions or issues ruthford.jay@oracle.com"
echo "" | awk '{print $1}'
