import boto3
import os

def lambda_handler(event, context):
    client = boto3.client('ses')
    emails = client.list_verified_email_addresses()

    sender = os.environ['SENDER_EMAIL']
    recipients = os.environ['RECIPIENT_EMAILS'].split("|")
    s3 = event['Records'][0]['s3']
    
    bucket=s3['bucket']['name']

    env=s3['object']['key'].split("/")[1]

    addresses = []
    for email in emails["VerifiedEmailAddresses"]:
        if email in recipients:
            addresses.append(email)

          
    client.send_templated_email(
        Source=sender,
        Destination={
            'ToAddresses': addresses,
        },
        Template=f'S3StateUpdate',
        TemplateData=f'{{"env":"{env}", "bucket":"{bucket}"}}'
    )

    return {
        'statusCode' : 200,
        'body': emails["VerifiedEmailAddresses"],
        'sender': sender,
        'recipients': recipients,
    }