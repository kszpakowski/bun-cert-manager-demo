build:
	docker build -t bun-cert-manager-demo .

run:
	docker run --rm --name bun-cert-manager-demo -d -v "$(shell pwd)/tls:/home/node/app/tls" -p 9443:9443 bun-cert-manager-demo

stop:
	docker kill bun-cert-manager-demo

gen-cert:
	openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out tls/tls.crt -keyout tls/tls.key -config tls/openssl.cnf

curl:
	curl -vvvv -k https://localhost:9443/

stress-test:
	ab -n 5000 -c 50 https://localhost:9443/

rotate-cert:
	cmctl --namespace=bun-cert-manager-demo renew tls-cert