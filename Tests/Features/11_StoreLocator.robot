*** Settings ***
Test Setup        Run Keywords    Open website   Read Data From JSON File  Log into EPS
Test Teardown     Run Keywords    Close All Browsers
Force Tags        Regression    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators.robot
Resource          ../../Resources/Variables.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Checkout.robot
Resource          ../../Keywords/Cart.robot
Resource          ../../Keywords/OrderConfirmation.robot
Resource          ../../Keywords/Shipping.robot
Resource          ../../Keywords/Payment.robot
Resource          ../../Keywords/PDP.robot
Resource          ../../Keywords/PLP.robot
Resource          ../../Keywords/CommonWeb.robot
Resource          ../../Keywords/Login.robot
Resource          ../../Keywords/Homepage.robot
Resource          ../../Keywords/StoreLocator.robot
Resource          ../../Keywords/GiftCard.robot
Resource          ../../Keywords/MyAccount.robot
Resource          ../../Keywords/DataReader.robot
Resource          ../../Keywords/Search.robot

*** Test Cases ***
Store Locators Map pin
    [Tags]   StoreLocator  SL1
    Open Store Locator page
    Fill and Search a Store from Store Locator page     ${store_zipCode}
    Check Store Locator fields
    Compare list of stores titles with the pin titles on map

Store Locator Filters
    [Tags]   StoreLocator    SL2
    Open Store Locator page
    Fill and Search a Store from Store Locator page     ${store_zipCode}
#    Check Distance filter
    Open Store Locator page
    Fill and Search a Store from Store Locator page     ${store_zipCode}
    Check If Boutique filter is working
    Fill and Search a Store from Store Locator page     ${store_zipCode}
    Check If Authorized filter is working

Store locator - Get Direction and View Store page
    [Tags]    StoreLocator  SL3
    Open Store Locator page
    Fill and Search a Store from Store Locator page     ${store_zipCode}
    Check Get Directions
    Open Store Locator page
    Fill and Search a Store from Store Locator page     ${store_zipCode}
    Check Services
    Click View Store
    Check View Store Name
    Check View Store Details
    Check Get Directions