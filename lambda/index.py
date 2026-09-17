import json
import os


def lambda_handler(event, context):
    response = {
        "message": "Lambda created with Terraform",
        "database_host": os.environ.get("DB_HOST"),
        "database_port": os.environ.get("DB_PORT"),
        "database_name": os.environ.get("DB_NAME"),
    }

    return {
        "statusCode": 200,
        "body": json.dumps(response),
    }