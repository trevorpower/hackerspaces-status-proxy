express = require 'express'
request = require 'request'

app = express.createServer()
app.use express.bodyParser()

app.post '/', (proxyRequest, proxyResponse) ->
  request proxyRequest.body.url, (error, apiResponse, apiBody) ->
    proxyResponse.json
      "headers": apiResponse.headers
      "body": JSON.parse apiBody

port = process.env.PORT
app.listen port, () -> console.log "Listening on port #{port}"
