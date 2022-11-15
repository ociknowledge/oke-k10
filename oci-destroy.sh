starttime=$(date +%s)
. ./setenv.sh

echo '-------Deleting NGIX and Kasten K10'
helm uninstall k10 -n kasten-io
kubectl delete ns nginx-example-base
kubectl delete ns kasten-io

#echo '-------Deleting objects from S3 Storage Bucket'
#oci os object bulk-delete -bn $OCI_MY_BUCKET --force

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Modified by Ruthford Jay"
echo "-------Email me if any suggestions or issues ruthford.jay@oracle.com"
echo "" | awk '{print $1}'
