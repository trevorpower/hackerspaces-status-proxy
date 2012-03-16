express = require 'express'
request = require 'request'

app = express.createServer()
app.use express.bodyParser()

app.post '/', (proxyRequest, proxyResponse) ->
  request proxyRequest.body.url, (error, apiResponse, apiBody) ->
    return proxyResponse.send error if error?
    try
      proxyResponse.send
        "headers": apiResponse.headers
        "body": JSON.parse apiBody
    catch e
      proxyResponse.send
        "headers": apiResponse.headers
        "body": apiBody
        "error": e.message
  proxyResponse.header 'Access-Control-Allow-Origin', '*'
  proxyResponse.header 'Access-Control-Allow-Method', 'POST'

port = process.env.PORT
app.listen port, () -> console.log "Listening on port #{port}"
