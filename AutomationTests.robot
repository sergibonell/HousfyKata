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

Empty User Login
    Open Login Page
    Attempt Login   \   \
    Check Error    Username is required

Empty Password Login
    Open Login Page
    Attempt Login    standard_user    \
    Check Error    Password is required

Invalid User Login
    Open Login Page
    Attempt Login    standard_user    fail
    Check Error    Username and password do not match any user in this service

Locked User Login
    Open Login Page
    Attempt Login    locked_out_user    secret_sauce
    Check Error    Sorry, this user has been locked out.

Add Product From Inventory
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    Add Product    Sauce Labs Backpack
    Open Shopping Cart
    Check Item Cart    Sauce Labs Backpack

Add Product From Detail
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    Open Product Detail    Sauce Labs Backpack
    Add Product Detail
    Open Shopping Cart
    Check Item Cart    Sauce Labs Backpack

Add and Remove All Products
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    ${count}=     SeleniumLibrary.Get Element Count     data:test:inventory-item
    FOR    ${index}    IN RANGE    0    ${count}
        ${product_name}=    Get Text    xpath: (//*[@class="inventory_item_name "])[${index + 1}]
        Click Button    xpath: (//div[@class="pricebar"]/button)[${index + 1}]
        Open Shopping Cart
        Check Item Cart    ${product_name}
        Click Button    xpath: (//div[@class="item_pricebar"]/button)
        Back To Inventory
    END

Test Alphabetical Ordering
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    Select From List By Index    data:test:product-sort-container   0
    ${elements}=    Get WebElements    xpath: //*[@class="inventory_item_name "]
    ${names}=   Create List
    FOR    ${element}    IN    @{elements}
        ${product_name}=    Get Text    ${element}
        Append To List    ${names}    ${product_name}
    END
    ${sorted_names}=    Copy List    ${names}
    Sort List    ${sorted_names}
    Lists Should Be Equal    ${names}    ${sorted_names}

Test Reverse Alphabetical Ordering
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    Select From List By Index    data:test:product-sort-container   1
    ${elements}=    Get WebElements    xpath: //*[@class="inventory_item_name "]
    ${names}=   Create List
    FOR    ${element}    IN    @{elements}
        ${product_name}=    Get Text    ${element}
        Append To List    ${names}    ${product_name}
    END
    ${sorted_names}=    Copy List    ${names}
    Sort List    ${sorted_names}
    Reverse List    ${sorted_names}
    Lists Should Be Equal    ${names}    ${sorted_names}

Test Price Ordering
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    Select From List By Index    data:test:product-sort-container   2
    ${elements}=    Get WebElements    xpath: //*[@class="inventory_item_price"]
    ${prices}=   Create List
    FOR    ${element}    IN    @{elements}
        ${product_price}=   Get Text    ${element}
        ${product_price}=   Strip String    ${product_price}     characters=$
        ${product_price}=   Convert To Number    ${product_price}
        Append To List    ${prices}    ${product_price}
    END
    ${sorted_prices}=    Copy List    ${prices}
    Sort List    ${sorted_prices}
    Lists Should Be Equal    ${prices}    ${sorted_prices}

Test Reverse Price Ordering
    Open Login Page
    Attempt Login    standard_user    secret_sauce
    Select From List By Index    data:test:product-sort-container   3
    ${elements}=    Get WebElements    xpath: //*[@class="inventory_item_price"]
    ${prices}=   Create List
    FOR    ${element}    IN    @{elements}
        ${product_price}=   Get Text    ${element}
        ${product_price}=   Strip String    ${product_price}     characters=$
        ${product_price}=   Convert To Number    ${product_price}
        Append To List    ${prices}    ${product_price}
    END
    ${sorted_prices}=    Copy List    ${prices}
    Sort List    ${sorted_prices}
    Reverse List    ${sorted_prices}
    Lists Should Be Equal    ${prices}    ${sorted_prices}