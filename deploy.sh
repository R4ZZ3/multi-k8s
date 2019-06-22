docker build -t rasmust92/multi-client:latest -t rasmust92/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rasmust92/multi-server:latest -t rasmust92/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rasmust92/multi-worker:latest -t rasmust92/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rasmust92/multi-client:latest
docker push rasmust92/multi-server:latest
docker push rasmust92/multi-worker:latest

docker push rasmust92/multi-client:$SHA
docker push rasmust92/multi-server:$SHA
docker push rasmust92/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rasmust92/multi-server:$SHA
kubectl set image deployments/server-deployment client=rasmust92/multi-client:$SHA
kubectl set image deployments/server-deployment worker=rasmust92/multi-worker:$SHA