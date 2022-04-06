// Include the AWS SDK module
const AWS = require('aws-sdk');

// Instantiate a DynamoDB document client with the SDK
let dynamo = new AWS.DynamoDB.DocumentClient();


// Use built-in module to get current date & time
let date = new Date();

// Store date and time in human-readable format in a variable
let now = date.toISOString();

// Define handler function, the entry point to our code for the Lambda service
// We receive the object that triggers the function as a parameter
exports.handler = async (event, context, callback) => {
  // if (!event.requestContext.authorizer) {
  //   errorResponse('Authorization not configured', context.awsRequestId, callback);
  //   return;
  // }

  let statusCode = 200;
  let body  = JSON.parse(event.body);

  console.log('Received event (', now, '): ', body);
  return;

  let params = {
      TableName:'sg-divesites',
      Item: {
          'id': event.id,
          'name':event.name,
          'city':event.city,
          'country':event.country,
          'description':event.description,
          'latitude':event.latitude,
          'longitude':event.longitude,
          'entry':event.entry,
          'depth':event.depth
      }
  };

  try {
    switch (event.routeKey) {
      case "DELETE /divesites/{id}":
        await dynamo
          .delete({
            TableName: "ds-divesites",
            Key: {
              title: event.title
            }
          })
          .promise();
        body = `Deleted item ${event.pathParameters.id}`;
        break;
      case "GET /divesites/{id}":
        body = await dynamo
          .get({
            TableName: params.TableName,
            Key: {
              id: event.id
            }
          })
          .promise();
        break;
      case "GET /divesites":
        body = await dynamo
            .scan({ 
                TableName: params.TableName
            })
            .promise();
        break;
      case "INFO":
        body = await dynamo
            .scan(params)
            .promise();
        break;
      case "PUT /divesites":
        let requestJSON = JSON.parse(event.body);
        await dynamo
          .put(params)
          .promise();
        body = `Put item ${requestJSON.id}`;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message + "\n\n" + JSON.stringify(event, 2, null);
  } finally {
    body = JSON.stringify(body);
  }

  const headers = {
    "Content-Type": "application/json"
  };

  return {
    statusCode,
    body,
    headers
  };
};
