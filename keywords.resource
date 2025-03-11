*** Settings ***
Documentation   Resource file for the login page tests.
Library     SeleniumLibrary
Library     DateTime

*** Keywords ***
Open Login Page
    Open Browser    https://www.saucedemo.com/  Chrome
    Wait For Condition    return document.readyState == "complete"  2   Page failed to load.

Attempt Login
    [Arguments]     ${username}     ${password}
    Input Text    user-name    ${username}   True
    Input Password    password    ${password}    True
    Click Button    login-button

Check Error
    [Arguments]     ${error}
    Element Should Contain    data:test:error    ${error}
