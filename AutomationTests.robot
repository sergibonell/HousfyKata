*** Settings ***
Documentation   Kata for the Junior QA position at Housfy.
Resource    keywords.resource

*** Test Cases ***
Successful Login
    Open Login Page
    ${before}=    Get Current Date    result_format=epoch
    Attempt Login    standard_user    secret_sauce
    ${after}=       Get Current Date    result_format=epoch
    Wait Until Location Contains    inventory.html  2   The page did not load.
    Should Be True    ${after} - ${before} < 2     The page took more than 2 seconds to load.

Empty User
    Open Login Page
    Attempt Login   \   \
    Check Error    Username is required

Empty Password
    Open Login Page
    Attempt Login    standard_user    \
    Check Error    Password is required

Invalid User
    Open Login Page
    Attempt Login    standard_user    fail
    Check Error    Username and password do not match any user in this service

Locked User
    Open Login Page
    Attempt Login    locked_out_user    secret_sauce
    Check Error    Sorry, this user has been locked out.