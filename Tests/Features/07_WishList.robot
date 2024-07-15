*** Settings ***
Test Setup        Run Keywords    Open website   Read Data From JSON File  Close dev tools icon
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
Check wishlist functionalities
    [Tags]  Wishlist
    Check if empty minicart is accessible from header
    Check if Login is accessible from header
    Check if Country Selector is accessible from Footer
    Close the Country Selector modal
    Access the Wishlist page and check the empty message
    Navigate to Category    womens
    Navigate to Subcategory    bracelets
    Navigate to l3 subcategory    all
    Add first number of products to wishlist from PLP    4
    Open the PDP with nth number from PLP product list    5
    Click on Wish icon from PDP
    Access the Wishlist page
    Verify if the previously added products from PLP are listed on Wishlist page
    Click on Add To Bag for nth element from Wishlist page    2
    Select Size    M
    Click Add To Cart from wishlist minicart
    Close the minicart
    Remove all products from Wishlist
    Check the empty message on Wishlist page

Wishlist PDP
    [Tags]  wishlist  CCMS-6884
    Navigate to Category    womens
    Navigate to Subcategory    bracelets
    Navigate to l3 subcategory    all
    Add first number of products to wishlist from PLP    1
    Access the Wishlist page
    Click on nth product from wishlist and verify it's navigated to PDP  1
    Check pdp bread crumbs are displayed    Women's    Bracelets