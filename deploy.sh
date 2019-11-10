docker build -t jordandlaman/multi-client:latest -t jordandlaman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jordandlaman/multi-server:latest -t jordandlaman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jordandlaman/multi-worker:latest -t jordandlaman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jordandlaman/multi-client:latest
docker push jordandlaman/multi-server:latest
docker push jordandlaman/multi-worker:latest

docker push jordandlaman/multi-client:$SHA
docker push jordandlaman/multi-server:$SHA
docker push jordandlaman/multi-worker:$SHA

kubectl apply -f k8s

echo $SHA

kubectl set image deployments/server-deployment server=jordandlaman/multi-server:$SHA
kuebctl set image deployments/client-deployment client=jordandlaman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jordandlaman/multi-worker:$SHA
