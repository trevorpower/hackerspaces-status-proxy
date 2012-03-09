express = require 'express'
request = require 'request'

app = express.createServer()
app.use express.bodyParser()

app.post '/', (proxyRequest, proxyResponse) ->
  request proxyRequest.body.url, (error, apiResponse, apiBody) ->
    try
      proxyResponse.json
        "headers": apiResponse.headers
        "body": JSON.parse apiBody
    catch e
      proxyResponse.json
        "error": e.message

port = process.env.PORT
app.listen port, () -> console.log "Listening on port #{port}"
