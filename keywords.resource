*** Settings ***
Documentation   Resource file for the login page tests.
Library     SeleniumLibrary

*** Keywords ***
Open Page
    Open Browser    https://www.saucedemo.com/  Chrome
