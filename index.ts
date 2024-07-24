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
      cert: fs.readFileSync('./tls/server.crt'),
      key: fs.readFileSync('./tls/server.key'),
    },
    app
  )
  .listen(port);
