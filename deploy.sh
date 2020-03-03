docker build -t zubr13/multi-client:latest -t zubr13/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zubr13/multi-server:latest -t zubr13/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zubr13/multi-worker:latest -t zubr13/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push zubr13/multi-client:latest
docker push zubr13/multi-server:latest
docker push zubr13/multi-worker:latest

docker push zubr13/multi-client:$SHA
docker push zubr13/multi-server:$SHA
docker push zubr13/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zubr13/multi-server:$SHA
kubectl set image deployments/client-deployment client=zubr13/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zubr13/multi-worker:$SHA