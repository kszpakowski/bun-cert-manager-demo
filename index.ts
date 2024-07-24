import express from "express"
import https from "https"
import fs from "fs"

const app = express()
const port = 9443

app.get('/', (req, res) => {
  res.send('Hello World!')
})

https
  .createServer(
    {
      cert: fs.readFileSync('./tls/tls.crt'),
      key: fs.readFileSync('./tls/tls.key'),
    },
    app
  )
  .listen(port);
