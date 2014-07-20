
# Introduction

Welcome to the documention of the JSON API of [Flapjack](http://flapjack.io).

See the [flapjack-diner](https://github.com/flpjck/flapjack-diner/) RubyGem which provides a Ruby consumer of this API.

## Required HTTP Headers

JSON API requires the `Content-Type` header to be set as follows. The `Accept` header is not required but recommended when the client expects a JSON response body.

### GET

`Accept: application/vnd.api+json`

### POST

`Content-Type: application/json` or
`Content-Type: application/vnd.api+json`

`Accept: application/vnd.api+json`

### PATCH

`Content-Type: application/json-patch+json`

`Accept: application/vnd.api+json`

### DELETE

No specific headers required.

## Relevant Specifications

- [JSON API (jsonapi.org)](http://jsonapi.org/)
- [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902)
- [HTTP 1.1 (RFC 2616)](http://www.w3.org/Protocols/rfc2616/rfc2616.html)

