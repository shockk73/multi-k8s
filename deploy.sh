docker build -t shockk73/multi-client:latest -t shockk73/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shockk73/multi-server:latest -t shockk73/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shockk73/multi-worker:latest -t shockk73/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shockk73/multi-client:latest
docker push shockk73/multi-server:latest
docker push shockk73/multi-worker:latest

docker push shockk73/multi-client:$SHA
docker push shockk73/multi-server:$SHA
docker push shockk73/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=shockk73/multi-client:$SHA
kubectl set image deployments/server-deployment server=shockk73/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shockk73/multi-worker:$SHA