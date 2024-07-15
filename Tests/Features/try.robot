#*** Settings ***
#Test Setup        Run Keywords    Open website   Read Data From JSON File  Close dev tools icon
#Test Teardown     Run Keywords    Close All Browsers
#Force Tags        Regression    automation
#Library           SeleniumLibrary    screenshot_root_directory=EMBED
#Resource          ../../Resources/Locators.robot
#Resource          ../../Resources/Variables.robot
#Resource          ../../Resources/Errors.robot
#Resource          ../../Keywords/Checkout.robot
#Resource          ../../Keywords/Cart.robot
#Resource          ../../Keywords/MiniCart.robot
#Resource          ../../Keywords/OrderConfirmation.robot
#Resource          ../../Keywords/Shipping.robot
#Resource          ../../Keywords/Payment.robot
#Resource          ../../Keywords/PDP.robot
#Resource          ../../Keywords/PLP.robot
#Resource          ../../Keywords/CommonWeb.robot
#Resource          ../../Keywords/Login.robot
#Resource          ../../Keywords/Homepage.robot
#Resource          ../../Keywords/StoreLocator.robot
#Resource          ../../Keywords/GiftCard.robot
#Resource          ../../Keywords/MyAccount.robot
#Resource          ../../Keywords/DataReader.robot
#Resource          ../../Keywords/Search.robot
#
#*** Test Cases ***
#Signed User/Physical Gift Card/
#    [Tags]  checkout
#    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
#    Search for a product from header search  Gift Card
#    Click search icon from header search
#    Close the Get the First Look modal
#    Check Gift card page location
#    Fill GC PDP with braillie  no
#    Click Add To Cart Button from PDP
#    Click on My Bag
#    Check shipping method group title in minicart  delivery
#    Check physical gift card details in minicart
#    Click on View Bag from minicart
#    Check shipping method icon  delivery
#    Check physical gift card details in cart
#    Verify order summary is correct in cart page for GC
#    Click on Checkout button from cart page
#    Sign in during checkout
#    Check gift card details in checkout
#    Verify order summary is correct in checkout page for GC
#    Click on Place Order CTA for payment    cc
#    Order Confirmation page is displayed for registered user
#    Verify shipping address in order confirmation page   ${REGISTERED_customerFirstName}   ${REGISTERED_customerLastName}  ${REGISTERED_customerStreetAddress}  ${REGISTERED_customerFlat}  ${REGISTERED_customerCity}  ${REGISTERED_customerState}  ${REGISTERED_customerZipcode}  ${REGISTERED_customerPhone}
#    Verify billing address in order confirmation page    ${REGISTERED_customerFirstName}   ${REGISTERED_customerLastName}  ${REGISTERED_customerStreetAddress}  ${REGISTERED_customerFlat}  ${REGISTERED_customerCity}  ${REGISTERED_customerState}  ${REGISTERED_customerZipcode}  ${REGISTERED_customerPhone}
#    Verify payment method CC in order confirmation page  ${REGISTERED_customerName}  ${REGISTERED_customerCardType}  ${REGISTERED_customerCardNumberMasked}  3/30
#    Check gift card details in confirmation page
#    Verify order summary is correct in confirmation page for GC
#    Go to home page
#    Go to Accounts    Orders & Returns
#    Check that the last order id is present in Order History
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##1- Footer Signup
##   Go to Footer Signup
##   Check blank value validation in footer signup
##   Check invalid email validation in footer signup
##   Check email footer signup
#
#
#
