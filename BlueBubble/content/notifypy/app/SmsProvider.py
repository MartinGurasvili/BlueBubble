from twilio.rest import Client

class SmsProvider:

    def __init__(self, accout_sid, auth_token, phone_number):
        self.client = Client(accout_sid, auth_token)
        self.phone_number = phone_number

    def send(self, to, title, message):
        call = self.client.messages.create(
            to = to,
            from_ = self.phone_number,
            body = message
        )
        return call