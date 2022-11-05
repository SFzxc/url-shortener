### API Docs

**Endpoint**: localhost:3000

**Error Format**:

```
{
  "error": {
    "message": "<error-message>",
    "type": "<error_class_name>",
    "code": <status-code>
  }
}
```
**APIs**:

`POST v1/shorten/encode`

**Description**: Create a shorten url from long original url.

**Request Body:**
|  Field 	|  Data type 	| Required  	| Example  	| Note |
|---	|---	|---	|---	|---	|
|  original_url 	|  string 	|  true 	|   https://www.tablesgenerator.com/markdown_tables	|  	|
|   expired_at	|  integer 	|   false	|   1667586575	| = 2022-11-05 01:29:35 +0700 (epoch time in seconds not miliseconds)	|

**Response**:
Success: 201 status code
```
{
  "data": {
    "short_url": "http://local.ly/TCAxdm6",
    "original_url": "https://www.tablesgenerator.com/markdown_tables"
  }
}
```

`GET v1/shorten/decode/:id`

**Description**: Decode a shorten url and return original url

**Request Params:**
|  Field 	|  Data type 	| Required  	| Example  	|
|---	|---	|---	|---	|
|  id 	|  string 	|  true 	|   TCAxdm6	|

**Response**:
Success: 200 status code
```
{
  "data": {
    "short_url": "http://local.ly/TCAxdm6",
    "original_url": "https://www.tablesgenerator.com/markdown_tables"
  }
}
```
