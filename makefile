build:
	docker build -t bun-cert-manager-demo .

run:
	docker run --rm --name bun-cert-manager-demo -d -v "$(shell pwd)/tls:/usr/src/app/tls" -p 9443:9443 bun-cert-manager-demo

stop:
	docker kill bun-cert-manager-demo

gen-cert:
	openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out tls/tls.crt -keyout tls/tls.key

curl:
	curl -vvvv -k https://localhost:9443/