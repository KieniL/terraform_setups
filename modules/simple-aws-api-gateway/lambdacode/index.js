const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context) => {
let body;
let statusCode = 200;
const headers = {
    "Content-Type": "application/json"
};
console.log(JSON.stringify(event));

try {
    switch (event.routeKey) {
    case "DELETE /items/{id}":
        await dynamo
        .delete({
            TableName: "all-items",
            Key: {
            itemId: event.pathParameters.id
            }
        })
        .promise();
        body = `Deleted item ${event.pathParameters.id}`;
        break;
    case "GET /items/{id}":
        body = await dynamo
        .get({
            TableName: "all-items",
            Key: {
            itemId: event.pathParameters.id
            }
        })
        .promise();
        break;
    case "GET /items":
        body = await dynamo.scan({ TableName: "all-items" }).promise();
        break;
    case "PUT /items":
        let requestJSON = JSON.parse(event.body);
        await dynamo
        .put({
            TableName: "all-items",
            Item: {
            itemId: requestJSON.itemId,
            price: requestJSON.price,
            name: requestJSON.name
            }
        })
        .promise();
        body = `Put item ${requestJSON.itemId}`;
        break;
    case "OPTIONS /items":
        break;
    case "OPTIONS /items/{id}":
        break;
    default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
} catch (err) {
    statusCode = 400;
    body = err.message;
} finally {
    body = JSON.stringify(body);
}

return {
    statusCode,
    body,
    headers
};
};