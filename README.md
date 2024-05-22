# MT4 EA Lock

MT4 EA Lock is an Expert Advisor (EA) for MetaTrader 4 (MT4) designed to manage access control for trading accounts based on authorized names or account numbers from Web request.


## About

MT4 EA Lock is a tool to control access to trading accounts based on predefined authorization criteria. It fetches a list of authorized names and account numbers from a specified URL and allows only authorized accounts to use the EA. Unauthorized accounts are prevented from using the EA.

## Features

- Fetches a list of authorized names and account numbers from a URL
- Validates trading accounts based on authorized names or account numbers
- Prevents unauthorized accounts from using the EA
- Supports error handling for various HTTP response codes and parsing errors

## Configuration

To configure the URL for the account name/number list and create the structure for the account list, follow these steps:

1. Create a text file named account_list.txt.
   
    Structure the file as follows:
    Authorized Name:
    Ali
    Abu
    
    Authorized Acc Number:
    1234556
    782387

3. Upload the account_list.txt file to a web server accessible via URL.

4. Open the MT4_EA_Lock.mq4 file in the MetaEditor or any text editor.

5. Locate the OnInit() function within the source code.

6. Find the line that defines the URL, for example:

    const string url = "https://example.com/account_list.txt";
    
    Replace "https://example.com/account_list.txt" with the URL of the uploaded account_list.txt file.

7. You may integrate the code into your existing ea on OnInit()

8.  Buy me coffee

## Contact

- Author: [@Fain_azif](https://t.me/Fain_azif)
- GitHub: [xtivat0r](https://github.com/xtivat0r)

