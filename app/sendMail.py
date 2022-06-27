import json
import os
import smtplib
from email.message import EmailMessage

import requests
from dotenv import load_dotenv

load_dotenv()

def lambda_handler(event, context):
    myurl = os.getenv("MY_URL")
    myuser = os.getenv("EMAIL_ADDRESS")
    passwd = os.getenv("EMAIL_PASSWORD")
    recipient = os.getenv("RECIPIENT_EMAIL")

    dog_info = requests.get(myurl).json()[0]
    dog_image_url = dog_info["url"]
    print(f"Successfully found our dog pic *__* : {dog_image_url}")

    try:
        msg = EmailMessage()
        msg["Subject"] = "Daily Dog Pic!!"
        msg["From"] = myuser
        msg["To"] = [recipient]

        msg.set_content(f"Our dog of the day pic!\n{dog_image_url}")
        msg.add_alternative(
            f"Dog of the day!<br/><img src='{dog_image_url}' width='300px'>", subtype="html"
        )

        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
            smtp.login(myuser, passwd)
            smtp.send_message(msg)

        print(f"Pic sent successfully!")
        return {
        "statusCode": 200,
        "body": json.dumps("SUCCESS!")
        }
    
    except Exception as err:
        print("Encountered an exception during execution!")
        raise err

# if __name__ == "__main__":
#     mail()
