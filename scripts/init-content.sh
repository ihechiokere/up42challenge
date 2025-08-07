#!/bin/bash

set -e

NAMESPACE="${NAMESPACE:-s3www-dev}"

echo "=== s3www Content Initialization ==="
echo "Initializing content in Kubernetes cluster..."
echo "Namespace: $NAMESPACE"
echo

kubectl delete pod content-init -n $NAMESPACE --ignore-not-found=true >/dev/null 2>&1

echo "Step 1: Creating MinIO client pod..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: content-init
  namespace: $NAMESPACE
spec:
  restartPolicy: Never
  containers:
  - name: mc
    image: minio/mc:latest
    command: ["/bin/sh"]
    args: ["-c", "sleep 600"]
    env:
    - name: MC_HOST_minio
      value: "http://minioadmin:minioadmin@minio-service:9000"
EOF

echo "Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/content-init -n $NAMESPACE --timeout=120s

echo "Step 2: Initializing MinIO client and creating bucket..."
kubectl exec content-init -n $NAMESPACE -- mc mb minio/content --ignore-existing

echo "Step 3: Creating index.html content..."
kubectl exec content-init -n $NAMESPACE -- sh -c 'cat > /tmp/index.html << "EOF"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>s3www - UP42 Challenge</title>
</head>
<body>
    <img src="https://media.giphy.com/media/VdiQKDAguhDSi37gn1/giphy.gif" alt="Success!" />
    <p>Successfully serving static content from MinIO via s3www!</p>
</body>
</html>
EOF'

echo "Step 4: Uploading content to MinIO bucket..."
kubectl exec content-init -n $NAMESPACE -- mc cp /tmp/index.html minio/content/index.html

echo "Step 5: Setting bucket policy for public read access..."
kubectl exec content-init -n $NAMESPACE -- mc anonymous set public minio/content

echo "Step 6: Verifying content upload..."
kubectl exec content-init -n $NAMESPACE -- mc ls minio/content/

echo "Step 7: Testing bucket access..."
kubectl exec content-init -n $NAMESPACE -- mc cat minio/content/index.html

echo "Step 8: Cleaning up initialization pod..."
kubectl delete pod content-init -n $NAMESPACE

echo
echo "Content initialization complete!"
echo "Bucket 'content' created with index.html"
echo "s3www should now serve content from MinIO"
echo
echo "Next steps:"
echo "1. Port-forward: kubectl port-forward -n $NAMESPACE svc/s3www-service 8080:80"
echo "2. Open browser: http://localhost:8080"
echo "3. You should see the UP42 challenge page with GIF!"