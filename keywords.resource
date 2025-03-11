*** Settings ***
Documentation   Resource file for the login page tests.
Library     SeleniumLibrary
Library     DateTime
Library     Collections
Library     String

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

Add Product
    [Arguments]     ${name}
    Click Button    xpath: //div[@class='inventory_item_label']/a/div[text()="${name}"]/ancestor::*[3]/div[@class='pricebar']/button

Open Shopping Cart
    Click Element    data:test:shopping-cart-link
    Wait For Condition    return document.readyState == "complete"  2   Page failed to load.

Check Item Cart
    [Arguments]     ${name}
    Page Should Contain Element    xpath: //div[@class='inventory_item_name'][text()="${name}"]     message=${name} wasn't found in the shopping cart.

Open Product Detail
    [Arguments]     ${name}
    Click Element    xpath: //div[@class='inventory_item_label']/a/div[text()="${name}"]/..
    
Add Product Detail
    Click Button    //div[@class="inventory_details_desc_container"]/button

Back To Inventory
    Click Button    continue-shopping
    Wait For Condition    return document.readyState == "complete"  2   Page failed to load.