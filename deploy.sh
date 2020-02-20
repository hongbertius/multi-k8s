docker build -t nottidock/multi-client:latest -t nottidock/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nottidock/multi-server:latest -t nottidock/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nottidock/multi-worker:latest -t nottidock/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nottidock/multi-client:$SHA
docker push nottidock/multi-server:$SHA
docker push nottidock/multi-worker:$SHA
docker push nottidock/multi-client:latest
docker push nottidock/multi-server:latest
docker push nottidock/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=nottidock/multi-server:$SHA
kubectl set image deployments/client-deployment client=nottidock/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nottidock/multi-worker:$SHA
