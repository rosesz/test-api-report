# Api example usage


```
$ curl -X POST --data "username=yourusername&password=yourpassword" http://localhost:3000/api/sign-in.json
{"auth_token":"5400edbca30c5a63de549e03735ebac"}
```

```
$ curl -H "Authorization: Token token=5400edbca30c5a63de549e03735ebac" http://localhost:3000/api/reports.json
```

```
$ curl -H "Authorization: Token token=5400edbca30c5a63de549e03735ebac"  POST --data "comment=Lorem ipsum" http://localhost:3000/api/reports/generate.json
```

