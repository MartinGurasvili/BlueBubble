import os
import traceback
from .__noti__ import sendNoti
from .exception import *
from functools import wraps
from time import sleep

class NotifyPy(object):

    """
    NotifyPy is Decorator used to send notification on exception.
    Right Now We can only use Param 'retryOn' or 'ignore' not both for handling exception.

    Gmail service is used to send notification to mail.
    Make Sure you have turn on "Less Secure App" if not then you can turn on from this link:
    https://myaccount.google.com/u/0/lesssecureapps
    """

    def __init__(
            self,
            gEmail,
            gPasswd,
            to,
            retryOn = None,
            ignore = None,
            title = 'Unexpected Error Was Occur! in function: {func}',
            message = """<p>Error Message:</p><br /> <pre>{errorMsg}</pre>""",
            logger = None,
            delay = 3,
            maxRetires = 1000,
            notification_type = 'mail',
            twilio_keys = {}
    ):
        """

        Parameters
        ----------
        gEmail : str
            gmail email address which is refer as `gEmail`. [required]
        gPasswd : str
            gmail email address password which is refer as `gPasswd`. [required]
        to : str
            `to` Email Address where notification will send. [required]
        retryOn : tuple or type
            `retryOn` is tuple list of Exception to retry on.
        ignore : type or tuple
            `ignore` ignore Exceptions any list is given.
        title : str
            `title` which will be used as title to send notification.
        message : str
            `message` who will used as message with exception in notification body.
        logger : instance
            `logger` is instance to log error if any occur.
        delay : int
            `delay` is delay internal in seconds on each retry. [required] if retryOn param is used [default is 3]
        maxRetires : int
            `maxRetires` is maximum number of retries if param retryOn is used. [default is 1000]

        Returns
        -------
        type


        """

        # Gmail
        self.user = gEmail
        self.passwd = gPasswd

        # mail message body
        self.title = title
        self.message = message

        # logger
        self.logger = logger
        self.delay = delay
        self.retryOn = retryOn

        # ignore Errors
        self.ignore = ignore

        # max retires
        self.maxRetires = maxRetires

        self.to = to

        # Gets the provider for the email
        self.provider = gEmail.split('@')[1].split('.')[0]

        # Type of notification
        self.notification_type = notification_type

        self.twilio_keys = twilio_keys


    def exception(self, e, function):
        """Exception Logger and sender

        Parameters
        ----------
        e : exception

        function : function


        Returns
        -------
        type


        """
        # check for logger
        if self.logger:
            self.logger.exception(e)

        # message error string
        errorMsg = traceback.format_exc()

        title = self.title.format(func=function.__name__)
        message = self.message.format(errorMsg=errorMsg)

        print(title)

        self.sendMsg(title, message)

        os._exit(1)

    def sendMsg(self, title, message):
        """Send Mail notification to dev

        Parameters
        ----------
        title : str
             `title`.
        message : string
            Error Exception including `message`.

        Returns
        -------
        type


        """
        sendNoti(self.user, self.passwd, self.to, title, message, provider = self.provider, notification_type = self.notification_type, twilio_keys = self.twilio_keys)

    def __call__(self, function):
        """Whenever the class instance is used as decorator.

        Parameters
        ----------
        function : type
            `function` is passed.

        Returns
        -------
        type


        """
        @wraps(function)

        def wrapFunction(*arg, **kwarg):
            if self.retryOn:
                i = 1
                while 1:

                    # check for max retries
                    if i >= self.maxRetires:
                        excMsg = "Max Retires ({}) Limit Exceed In functon: \"{}\" with retry Exceptions: \"{}\"".format(
                        self.maxRetires,
                        function.__name__,
                        ", ".join(exc.__name__ for exc in self.retryOn) if self.retryOn is tuple else self.retryOn.__name__
                        )

                        # send mail
                        self.sendMsg(excMsg, excMsg)

                        raise MaxRetriesLimitExceed(excMsg)

                    try:
                        return function(*arg, **kwarg)
                    except self.retryOn:
                        sleep(self.delay)
                        i += 1

                    except Exception as e:
                        self.exception(e, function)
            elif self.ignore:

                try:
                    return function(*arg, **kwarg)
                except self.ignore:
                    pass
                except Exception as e:
                    self.exception(e, function)

            else:
                try:
                    return function(*arg, **kwarg)
                except Exception as e:
                    self.exception(e, function)

        return wrapFunction
