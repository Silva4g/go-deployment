build:
	GOOS=linux GOARCH=amd64 go build -o dist/simple-http-server

send-exe-to-remote-server:
	rsync dist/simple-http-server root@server:22

deploy: build send-exe-to-remote-server