
//+------------------------------------------------------------------+
//|                                                   GITHUBLOCK.mq4 |
//|                          Copyright 2024, https://t.me/Fain_azif. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, https://t.me/Fain_azif."
#property link      "https://t.me/Fain_azif"
#property version   "1.00"

int OnInit()
{
    const string url = "https://raw.githubusercontent.com/xtivat0r/LockGITHUB-EA/main/acc.txt";
    const int timeout = 5000;
    string headers, result_headers, cookie = NULL;
    char post[], result[];

    int res = WebRequest("GET", url, cookie, "Cache-Control: no-cache\r\nPragma: no-cache\r\n", timeout, post, 0, result, headers);

    if(res != 200) {
        string errorDescription;
        if (res == -1) errorDescription = "Common error. Possibly due to no permissions or incorrect URL.";
        else if (res == -2) errorDescription = "Timeout error.";
        else if (res == -3) errorDescription = "Lost connection.";
        else if (res == -4) errorDescription = "Internal MQL4 error.";
        else errorDescription = "Unknown error.";

        Print("Error fetching data. HTTP Error Code: ", res, ". ", errorDescription);
        ExpertRemove();
        return(INIT_FAILED);
    }

    string result_str = CharArrayToString(result);

    // Extract the authorized names and numbers
    int nameStart = StringFind(result_str, "Authorized Name:") + StringLen("Authorized Name:");
    int nameEnd = StringFind(result_str, "Authorized Acc Number:");
    int numberStart = nameEnd + StringLen("Authorized Acc Number:");
    int numberEnd = StringLen(result_str);

    if(nameStart == -1 || nameEnd == -1 || numberStart == -1 || numberEnd == -1 || nameEnd <= nameStart || numberEnd <= numberStart) {
        Print("Error parsing data: Invalid format.");
        ExpertRemove();
        return(INIT_FAILED);
    }

    string authorizedNames = StringSubstr(result_str, nameStart, nameEnd - nameStart);
    string authorizedNumbers = StringSubstr(result_str, numberStart, numberEnd - numberStart);

    //Print("Extracted Names: ", authorizedNames); // Debug print
    //Print("Extracted Numbers: ", authorizedNumbers); // Debug print

    string names[], numbers[];
    StringSplit(authorizedNames, '\n', names);
    StringSplit(authorizedNumbers, '\n', numbers);

    // Trim spaces and newlines from each name/number
    for(int i = 0; i < ArraySize(names); i++) {
        names[i] = StringTrim(names[i]);
    }
    for(int j = 0; j < ArraySize(numbers); j++) {
        numbers[j] = StringTrim(numbers[j]);
    }

    string accountName = AccountInfoString(ACCOUNT_NAME);
    int accountNumber = (int)AccountInfoInteger(ACCOUNT_LOGIN);
    bool isValid = false;
    bool usingName = false; // Track if validation was done using account name

    // Check if account name is authorized
    for(int e = 0; e < ArraySize(names); e++) {
        Print("Checking authorized name: ", names[e]); // Debug print
        if(accountName == names[e]) {
            isValid = true;
            usingName = true;
            Alert("Account Name authorized: ", accountName);
            break;
        }
    }

    // If validation was not done using account name, check if it was done using account number
    if(!usingName) {
        for(int f = 0; f < ArraySize(numbers); f++) {
            Print("Checking authorized number: ", numbers[f]); // Debug print
            if(IntegerToString(accountNumber) == numbers[f]) {
                isValid = true;
                Alert("Account Number authorized: ", accountNumber);
                break;
            }
        }
    }

    if(!isValid) {
        Alert("Account not authorized to use this EA");
        ExpertRemove();
        return(INIT_FAILED);
    }

    Print("Initializing EA...");

    // Clear arrays
    ArrayFree(result);
    ArrayFree(names);
    ArrayFree(numbers);

    return(INIT_SUCCEEDED);
}



//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
  
void OnTick()
  {

  }

//+------------------------------------------------------------------+
//| Custom StringTrim function                                       |
//+------------------------------------------------------------------+
string StringTrim(string str)
{
   int start = 0, end = StringLen(str) - 1;

   // Trim leading spaces
   while(start <= end && (StringGetChar(str, start) == ' ' || StringGetChar(str, start) == '\t' || StringGetChar(str, start) == '\r' || StringGetChar(str, start) == '\n'))
      start++;

   // Trim trailing spaces
   while(end >= start && (StringGetChar(str, end) == ' ' || StringGetChar(str, end) == '\t' || StringGetChar(str, end) == '\r' || StringGetChar(str, end) == '\n'))
      end--;

   return StringSubstr(str, start, end - start + 1);
}
