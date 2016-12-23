---
title: API Reference
search: true
---


# Orders


## Creating an order

First, create an order, then make a later request to get it back

```json


```

### HTTP Request

`POST http://example.com/orders`

```json

{
  "email": "email@example.com",
  "name": "Order 1",
  "paid": true
}
```

### HTTP Request

`GET http://example.com/orders/9`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
name | true | Name of order
paid | true | If the order has been paid for
email | false | Email of the user that placed the order

### Response Fields

Parameter | Type | Description
--------- | ------- | -----------
name | string | Name of order
paid | integer | If the order has been paid for
email | string | Email of the user that placed the order

## Viewing an order

Make a request to get an order

```json

{
  "email": "email@example.com",
  "name": "Order 1",
  "paid": true
}
```

### HTTP Request

`GET http://example.com/orders/9`


### Response Fields

Parameter | Type | Description
--------- | ------- | -----------
name | string | Name of order
paid | integer | If the order has been paid for
email | string | Email of the user that placed the order

## Deleting an order



```json

{
  "email": "email@example.com",
  "name": "Order 1",
  "paid": true
}
```

### HTTP Request

`GET http://example.com/orders/9`

