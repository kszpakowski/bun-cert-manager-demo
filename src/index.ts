import express from "express"
import https from "https"
import fs from "fs"

const sslKeyPath = './tls/tls.key'
const sslCertPath = './tls/tls.crt'

const app = express()
const port = 9443

app.get('/', (req, res) => {
  res.send('Hello World!')
})


function readCertsSync() {
  return {
    key: fs.readFileSync(sslKeyPath),
    cert: fs.readFileSync(sslCertPath)
  }
}

const httpd = https.createServer(readCertsSync(), app)
  .listen(port, () => console.log(`Listening on port: ${port} 🚀`));


let waitForCertAndFullChainToGetUpdatedTooTimeout: ReturnType<typeof setTimeout>;
fs.watch(sslKeyPath, () => {
  console.log('Certificate update detected, updating secure context.')
  clearTimeout(waitForCertAndFullChainToGetUpdatedTooTimeout);
  waitForCertAndFullChainToGetUpdatedTooTimeout = setTimeout(() => {
    httpd.setSecureContext(readCertsSync());
  }, 1000);
});