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
Resource          ../../Keywords/MiniCart.robot
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
01-Signed User/Delivery Item/Visa Card
    [Tags]  checkout  01
    Register a user and add details
    Logout
    Search for a product from header search  ${Delivery_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${Delivery_productSize}
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  ${Delivery_productSize}
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart   delivery  ${Delivery_productSize}
    ##lauch mini bag
    Verify order summary in correct in cart page
   IF   '${shopLocale}' in ['US']
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page shipping information for logged in user
    Verify delivery details in checkout page    Delivery
    Check that the default Delivery Method is selected     ${Default_Delivery_Method}
    Check delivery date and message for the shipping method   ${Default_Delivery_Method}
    Verify shipping charge for selected delivery   ${Default_Delivery_Method}
    Verify order summary in checkout page   ${Default_Delivery_Method}   ${Delivery_productSize}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Click on Edit Shipping link from Payment step
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}   ${NewUser_StreetAddress_EDITED}  ${NewUser_Flat_EDITED}  ${NewUser_City_EDITED}  ${NewUser_State_EDITED}  ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Select Delivery    2-day
    Check delivery date and message for the shipping method  2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify payment page shipping information   ${Default_Delivery_Method}
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page   ${Default_Delivery_Method}  ${Delivery_productSize}
    Enter cvv number  ${NewUser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}   ${NewUser_StreetAddress_EDITED}  ${NewUser_Flat_EDITED}  ${NewUser_City_EDITED}  ${NewUser_State_EDITED}  ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Verify billing address in order confirmation page    ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}   ${NewUser_StreetAddress_EDITED}  ${NewUser_Flat_EDITED}  ${NewUser_City_EDITED}  ${NewUser_State_EDITED}  ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${NewUser_CardType}  ${NewUser_CardNumberMasked}  3/30
    Verify order details section in confirmation page    ${Default_Delivery_Method}  ${Delivery_productSize}
   ELSE IF   '${shopLocale}' in ['CN']
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page shipping information for logged in user
    Verify delivery details in checkout page    Delivery
    Check that the default Delivery Method is selected     ${Default_Delivery_Method}
    Check delivery date and message for the shipping method   ${Default_Delivery_Method}
    Verify shipping charge for selected delivery   ${Default_Delivery_Method}
    Verify order summary in checkout page   ${Default_Delivery_Method}   ${Delivery_productSize}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Click on Edit Shipping link from Payment step
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}   ${NewUser_StreetAddress_EDITED}  ${NewUser_Flat_EDITED}  ${NewUser_City_EDITED}  ${NewUser_State_EDITED}  ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Select Delivery    3 to 5 days
    Check delivery date and message for the shipping method  3 to 5 days
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify payment page shipping information   ${Default_Delivery_Method}
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page   ${Default_Delivery_Method}  ${Delivery_productSize}
    Enter cvv number  ${NewUser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}   ${NewUser_StreetAddress_EDITED}  ${NewUser_Flat_EDITED}  ${NewUser_City_EDITED}  ${NewUser_State_EDITED}  ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Verify billing address in order confirmation page    ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}   ${NewUser_StreetAddress_EDITED}  ${NewUser_Flat_EDITED}  ${NewUser_City_EDITED}  ${NewUser_State_EDITED}  ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${NewUser_CardType}  ${NewUser_CardNumberMasked}  3/30
    Verify order details section in confirmation page    ${Default_Delivery_Method}  ${Delivery_productSize}
   ELSE
    Click on Checkout button from Cart page for EU
#    Sign in during checkout for EU
    Fill in Login Form    ${guest_valid}    ${NewUser_Pwd}
    Click on Login button
    Verify order summary data in payment page for EU    ${Delivery_productSize}
    Verify billing details in payment page for EU   ${FIRST_NAME} ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Verify delivery details in payment page for EU
    Verify shipping details in payment page for EU
    Verify billing summary in payment page for EU
    Enter visa payment details for EU  ${NewUser_CardNumber}    ${NewUser_CardCvv}
    Click on Place Order CTA for payment for EU    cc
    Order Confirmation page is displayed for registered user in EU
    Verify billing address in order confirmation page for EU   ${FIRST_NAME} ${LAST_NAME}  ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Verify shipping address in order confirmation page for EU   ${FIRST_NAME} ${LAST_NAME}  ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Verify payment method in order confirmation page for EU  Visa
    Verify billing summary in order confirmation page for EU
    Verify order summary data in order confirmation page for EU   ${Delivery_productSize}
   END
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History


02-BOPIS Item/Signed User/Visa
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    [Tags]  checkout
    Register a user and add details
    Search for a product from header search  ${BOPIS_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize}
    Open BOPIS modal
    Select available store at    ${store_zipCode}
    Capture item details from PDP
    Save the product subtitle on PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  pick up
    Compare item details in minicart with PDP  ${BOPIS_productSize}
    Click on View Bag from minicart
    Check shipping method icon  pick up
    Compare item details in cart with minicart  pick up  ${BOPIS_productSize}
    Verify order summary in correct in cart page
    Click on Checkout button from Cart page
    Sleep  5s
    Verify checkout page your information for logged in user
    Verify delivery details in checkout page    pick up
    Check Change delivery person checkbox
    Fill Change delivery person form
    Verify order summary in checkout page   pick up  ${BOPIS_productSize}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information   pick up
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page   pick up  ${BOPIS_productSize}
#    Select the PayPal payment method
#    Sleep  2s
#    Log into PayPal
#    On Paypal Account click on Save and Continue
#    Click on Place Order CTA for payment    paypal
    Enter cvv number  ${Newuser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify store address in order confirmation page
    Verify billing address in order confirmation page for paypal    ${paypal_firstname}   ${paypal_lastname}  ${paypal_address1}  ${paypal_address2}  ${paypal_city}   ${paypal_state}   ${paypal_postalcode}   ${paypal_country}   ${paypal_phone}
    Verify payment method paypal in order confirmation page
    Verify order details section in confirmation page   pick up  ${BOPIS_productSize}
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

03-Pre order Item/Signed User/Visa
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    [Tags]  checkout
    Register a user and add details
    Logout
    Search for a product from header search  ${Preorder_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${Preorder_productSize}
    Capture item details from PDP
    Save the product subtitle on PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  pre order
    Compare item details in minicart with PDP  ${Preorder_productSize}
    Click on View Bag from minicart
    Check shipping method icon  pre order
    Compare item details in cart with minicart   pre order  ${Preorder_productSize}
    Verify order summary in correct in cart page
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Click on forgot password button from Checkout
    Close forgot password slide out
    Click on forgot password button from Checkout
    Verify forgot password slideout from checkout page
    Validate invalid login from checkout page
    Sign in during checkout
    Verify checkout page shipping information for logged in user
    Verify delivery details in checkout page    pre order
    Check that the default Delivery Method is selected     ${Default_Delivery_Method}
    Verify shipping charge for selected delivery   ${Default_Delivery_Method}
    Verify order summary in checkout page   pre order  ${Preorder_productSize}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information   pre order
    Verify payment section for logged in user with preorder item
    Verify whether credit card is preselected
    Verify order summary in payment page   pre order   ${Preorder_productSize}
    Check that PayPal and affirm payment options are not listed when buying preorder items
    Enter cvv number  ${NewUser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Verify order details section in confirmation page   ${Default_Delivery_Method}  ${Preorder_productSize}
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

04-Signed User/Smart Post Item/Paypal from minicart
    [Tags]  checkout  re
    Skip If   '${shopLocale}' in ['CN','UK','FR','GR','IT']
    Register a user and add details
    Logout
    Click on Sign In
    Fill in Login Form              ${guest_valid}     ${NewUser_Pwd}
    Click on Login
    Check Email in Account Page     ${guest_valid}
    Search for a product from header search  192740806254
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  M
    Capture item details from PDP
    Save the product subtitle on PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  delivery
    Compare item details in minicart with PDP  M
    Click paypal checkout from minicart
    Log into PayPal
    On Paypal Account click on Save and Continue
    Verify payment page shipping information   ${Default_Delivery_Method}
    Verify order summary in payment page   standard  M
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Verify order details section in confirmation page   ${Default_Delivery_Method}  M
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

05-Signed User/Ring Sizer/$0 item
    [Tags]  checkout  rs
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT','CN']
    Register a user and add details
    Logout
    Search for a product from header search  Ring Sizer
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Capture Ring sizer details from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  delivery
    Check ring sizer details in miniCart
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart for ring sizer
    Verify order summary in correct in cart page for ring sizer
    Click on Checkout button from cart page
    Verify order summary in payment page for ring sizer
    Click on Sign In button from Checkout
    Sign in during checkout
    Select Delivery    Standard
    Click on Continue To Payment button
    Click on Place Order CTA for payment    zero_order
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify order details section in confirmation page for ring sizer
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

06-Signed User/Virtual Gift Card/Visa
    [Tags]  checkout
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    Register a user and add details
    Logout
    Search for a product from header search  Virtual Gift Card
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Fill Virtual GC PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Check virtual gift card details in minicart
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Check virtual gift card details in cart
    Verify order summary is correct in cart page for VGC
    Click on Checkout button from cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Check virtual gift card details in checkout
    Verify order summary is correct in checkout page for VGC
    Check prepopulated VGC fields
    Enter Gift message
    Enter cvv number  ${Newuser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Check virtual gift card details in confirmation page
    Verify order summary is correct in confirmation page for VGC
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History


07-Signed User/Physical Gift Card/Affirm
    [Tags]  checkout  siafr
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    Register a user and add details
    Logout
    Search for a product from header search  Gift Card
    Click search icon from header search
    Close the Get the First Look modal
    Check Gift card page location
    Fill GC PDP with braillie  no
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  delivery
    Check physical gift card details in minicart
    Click on View Bag from minicart
    Check shipping method icon  delivery
    Check physical gift card details in cart
    Verify order summary is correct in cart page for GC
    Click on Checkout button from cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Check gift card details in checkout
    Verify order summary is correct in checkout page for GC
    Select an Address from Address Suggestion modal    entered
    Click on Continue To Payment button
    Select the Affirm payment method
    Check that the Affirm Checkout modal is displayed
   IF  '${shopLocale}' in ['US']
    Enter and submit the phone number on Affirm Checkout modal
    Enter Affirm PIN within the "We just texted you" modal
    Choose and Affirm payment plan for number of months    12
    Click on Choose This Affirm Plan button
    Run Keyword And Ignore Error    Verify identity on Affirm Payment Plan modal
    Agree to DY policy on Affirm Review And Pay modal
    Confirm the Affirm payment
   ELSE
    Enter and submit the phone number on Affirm Checkout modal
    Enter Affirm PIN within the "We just texted you" modal
    Choose and Affirm payment plan for number of months    12
    Click on Choose This Affirm Plan button
    Agree to PAD agreement on Affir Review And Pay modal
    Agree to DY policy on Affirm Review And Pay modal
#    sleep  1200s
    Confirm the Affirm payment
   END
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Check gift card details in confirmation page
    Verify order summary is correct in confirmation page for GC
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

08-Signed User/Multiple Delivery Item/Paypal
    [Tags]  checkout  mp
    Register a user and add details
    Logout
    Search for a product from header search  ${Delivery_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${Delivery_productSize}
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Close the minicart
    Search for a product from header search  ${Delivery_product_2}
    Click search icon from header search
    Open the Product from PLP product list  1
    Select Size   ${Delivery_productSize_2}
    Capture item details from PDP for second product
    Click Add To Cart Button from PDP
    Check total minicart item quantity  2
    Check whether correct no:of products are added under group title in minicart   delivery    2
    Verify whether last added product is shown first in minicart
    Compare item details in minicart for 2 products  ${Delivery_productSize}   ${Delivery_productSize_2}
    Click on View Bag from minicart
    Check shipping method icon  delivery
    Check whether correct no:of products are added under group title in cart   delivery   2
    Verify whether last added product is shown first in cart
    Compare item details in cart for 2 products  ${Delivery_productSize}   ${Delivery_productSize_2}
   IF   '${shopLocale}' in ['US','CN']
    Verify order summary in correct in cart page for 2 products
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page shipping information for logged in user
    Verify delivery details in checkout page for 2 products   delivery  ${Delivery_productSize}   ${Delivery_productSize_2}
    Check that the default Delivery Method is selected     ${Default_Delivery_Method}
    Check delivery date and message for the shipping method   ${Default_Delivery_Method}
    Verify shipping charge for selected delivery   ${Default_Delivery_Method}
    Verify order summary in checkout page for 2 products   ${Default_Delivery_Method}   ${Delivery_productSize}  ${Delivery_productSize_2}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information for 2 products   ${Default_Delivery_Method}
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page for 2 products   ${Default_Delivery_Method}  ${Delivery_productSize}  ${Delivery_productSize_2}
    Select the PayPal payment method
    Sleep  2s
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed for registered user
    Verify shipping address in order confirmation page   ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method paypal in order confirmation page
    Verify order details section in confirmation page for 2 products   ${Default_Delivery_Method}  ${Delivery_productSize}  ${Delivery_productSize_2}
   ELSE IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Verify order summary is correct in cart page for 2 products - EU
    Click on Checkout button from Cart page for EU
#    Click on Sign In button from Checkout
#    Sign in during checkout for EU
    Fill in Login Form    ${guest_valid}    ${NewUser_Pwd}
    Click on Login button
    Verify order summary data in payment page for EU for 2 products    ${Delivery_productSize}  ${Delivery_productSize_2}
    Verify billing details in payment page for EU   ${FIRST_NAME}  ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Verify delivery details in payment page for EU
    Verify shipping details in payment page for EU
    Verify billing summary in payment page for EU for 2 products
#    Launch and close klarna pay in 3
    Launch and close gpay
#    Select the PayPal payment method for EU
#    Sleep  2s
#    Log into PayPal for EU
#    On Paypal Account click on Save and Continue for EU
    Fill in credit card details in payments page - visa
    Click on Place Order CTA for payment for EU    cc
    Order Confirmation page is displayed for registered user in EU
    Verify billing address in order confirmation page for EU   ${FIRST_NAME}  ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Verify shipping address in order confirmation page for EU   ${FIRST_NAME}  ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Verify payment method in order confirmation page for EU   Visa
    Verify billing summary in order confirmation page for EU
    Verify order summary data in order confirmation page for EU for 2 products   ${Delivery_productSize}  ${Delivery_productSize_2}
   END
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History


09-Signed User/Multiple BOPIS Same Store/Paypal
    [Tags]  checkout  mbss
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    Register a user and add details
    Logout
    Search for a product from header search  ${BOPIS_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize}
    Open BOPIS modal
    Select available store at    ${store_zipCode}
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Close the minicart
    Search for a product from header search  ${BOPIS_product_2}
    Click search icon from header search
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize_2}
    Capture item details from PDP for second product
    Click Add To Cart Button from PDP
    Check total minicart item quantity  2
    Check whether correct no:of products are added under group title in minicart   pick up same store    2
    Verify whether last added product is shown first in minicart
    Compare item details in minicart for 2 products  ${BOPIS_productSize}   ${BOPIS_productSize_2}
    Click on View Bag from minicart
    Check shipping method icon  pick up
    Check whether correct no:of products are added under group title in cart   pick up same store   2
    Verify whether last added product is shown first in cart
    Compare item details in cart for 2 products  ${BOPIS_productSize}   ${BOPIS_productSize_2}
    Verify order summary in correct in cart page for 2 products
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page your information for logged in user
    Verify delivery details in checkout page for 2 products   pick up same store  ${BOPIS_productSize}   ${BOPIS_productSize_2}
    Check that the default delivery method is selected    pick Up in Store
    Check delivery message for pickup order
    Verify shipping charge for selected delivery   pick up
    Verify order summary in checkout page for 2 products   pick up  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information   pick up
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page for 2 products   pick up  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Select the PayPal payment method
    Sleep  2s
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
#    Enter cvv number  ${Newuser_CardCvv}
#    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify store address in order confirmation page
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
#    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Verify payment method paypal in order confirmation page
    Verify order details section in confirmation page for 2 products   pick up  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

10-Signed User/Multiple BOPIS different Store/Visa
    [Tags]  checkout
    Skip If   '${shopLocale}' in ['CN','UK','FR','GR','IT']
    Register a user and add details
    Logout
    Search for a product from header search  ${BOPIS_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize}
    Open BOPIS modal
    Select available store at    ${store_zipCode}
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Close the minicart
    Search for a product from header search  ${BOPIS_product_2}
    Click search icon from header search
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize_2}
    Open BOPIS modal
    Select available store for second product at    ${store_zipCode_2}
    Capture item details from PDP for second product
    Click Add To Cart Button from PDP
    Check total minicart item quantity  2
    Check whether correct no:of products are added under group title in minicart   pick up different store    2
    Verify whether last added product is shown first in minicart
    Compare item details in minicart for 2 products  ${BOPIS_productSize}   ${BOPIS_productSize_2}
    Click on View Bag from minicart
    Check shipping method icon  pick up
    Check whether correct no:of products are added under group title in cart   pick up different store   2
    Verify whether last added product is shown first in cart
    Verify order summary in correct in cart page for 2 products
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page your information for logged in user
    Verify delivery details in checkout page for 2 products different store  ${BOPIS_productSize}   ${BOPIS_productSize_2}
    Check that the default delivery method is selected    pick Up in Store
    Check delivery message for pickup order
    Verify shipping charge for selected delivery   pick up
    Verify order summary in checkout page for 2 products   pick up  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information   pick up
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page for 2 products   pick up  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Enter cvv number  ${Newuser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify store address in order confirmation page
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Verify order details section in confirmation page for 2 products   pick up  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

11-Signed User/Mixed Cart - BOPIS + Delivery/Visa
    [Tags]  checkout  mixcartu
    Skip If   '${shopLocale}' in ['CN','UK','FR','GR','IT']
    Register a user and add details
    Logout
    Search for a product from header search  ${BOPIS_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize}
    Open BOPIS modal
    Select available store at    ${store_zipCode}
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Close the minicart
    Search for a product from header search  ${Delivery_product}
    Click search icon from header search
    Open the Product from PLP product list  1
    Select Size  ${Delivery_productSize}
    Click deliver to address radio button
    sleep  3s
    Capture item details from PDP for second product
    Click Add To Cart Button from PDP
    Check total minicart item quantity  2
    Check whether correct no:of products are added under group title in minicart for mixed cart delivery and bopis
    Verify whether last added product is shown first in minicart
    Compare item details in minicart for 2 products  ${BOPIS_productSize}   ${Delivery_productSize}
    Click on View Bag from minicart
    Check whether correct no:of products are added under group title in cart for mixed cart delivery and bopis
    Verify whether last added product is shown first in cart
#    Compare item details in cart for 2 products  ${BOPIS_productSize}   ${Delivery_productSize}
    Verify order summary in correct in cart page for 2 products
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page your information for logged in user
    Verify delivery details in checkout page for mixed cart bopis and delivery  ${BOPIS_productSize}   ${Delivery_productSize}
    Check that the default delivery method is selected    Pick Up in Store
    Check delivery message for pickup order
    Verify shipping charge for selected delivery   pick up
    Check that the default delivery method is selected    delivery
    Check delivery date and message for the shipping method    2-day
    Verify shipping charge for selected delivery   2-day
    Verify order summary in checkout page for mixed cart bopis and delivery  ${BOPIS_productSize}  ${Delivery_productSize}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information for mixed cart bopis and delivery
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page for mixed cart bopis and delivery  ${BOPIS_productSize}  ${Delivery_productSize}
    Enter cvv number  ${Newuser_CardCvv}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed for registered user
    Verify store address in order confirmation page
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Verify order details section in confirmation page for mixed cart bopis and delivery  ${BOPIS_productSize}  ${Delivery_productSize}
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

11-Signed User/Mixed Cart - BOPIS + Delivery/Paypal - CN
    [Tags]  checkout  mixcart
    Skip If   '${shopLocale}' in ['US','UK','FR','GR','IT']
    Register a user and add details
    Logout
    Search for a product from header search  ${BOPIS_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size  ${BOPIS_productSize}
    Open BOPIS modal
    Select available store at    ${store_zipCode}
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Close the minicart
    Search for a product from header search  ${Delivery_product}
    Click search icon from header search
    Open the Product from PLP product list  1
    Select Size  ${Delivery_productSize}
    Click deliver to address radio button
    sleep  3s
    Capture item details from PDP for second product
    Click Add To Cart Button from PDP
    Check total minicart item quantity  2
    Check whether correct no:of products are added under group title in minicart for mixed cart delivery and bopis
    Verify whether last added product is shown first in minicart
    Compare item details in minicart for 2 products  ${BOPIS_productSize}   ${Delivery_productSize}
    Click on View Bag from minicart
    Check whether correct no:of products are added under group title in cart for mixed cart delivery and bopis
    Verify whether last added product is shown first in cart
#    Compare item details in cart for 2 products  ${BOPIS_productSize}   ${Delivery_productSize}
    Verify order summary in correct in cart page for 2 products
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Sign in during checkout
    Verify checkout page your information for logged in user
#    sleep  600s
    Verify delivery details in checkout page for mixed cart bopis and delivery  ${BOPIS_productSize}   ${BOPIS_productSize_2}
    Check that the default delivery method is selected    Pick Up in Store
    Check delivery message for pickup order
    Verify shipping charge for selected delivery   pick up
    Check that the default delivery method is selected    delivery
    Check delivery date and message for the shipping method    3 to 5 days
    Verify shipping charge for selected delivery   3 to 5 days
    Verify order summary in checkout page for mixed cart bopis and delivery  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Check if complimentary links are displayed in checkout page
    Click on Continue To Payment button
    Verify payment page shipping information for mixed cart bopis and delivery
    Verify payment section for logged in user
    Verify whether credit card is preselected
    Verify order summary in payment page for mixed cart bopis and delivery  ${BOPIS_productSize}  ${BOPIS_productSize_2}
#    Enter cvv number  ${Newuser_CardCvv}
#    Click on Place Order CTA for payment    cc
    Select the PayPal payment method
    Sleep  2s
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed for registered user
    Verify store address in order confirmation page
    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
#    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
    Verify payment method paypal in order confirmation page
    Verify order details section in confirmation page for mixed cart bopis and delivery  ${BOPIS_productSize}  ${BOPIS_productSize_2}
    Go to home page
    Go to Accounts    Orders & Returns
    Check that the last order id is present in Order History

#12-Paypal checkout from cart page
#    [Tags]  checkout
#    Skip If   '${shopLocale}' in ['UK','FR','GR','IT','CN']
#    Register a user and add details
#    Logout
#    Search for a product from header search  Ring Sizer
#    Click search icon from header search
#    Close the Get the First Look modal
#    Open the Product from PLP product list  1
#    Capture Ring sizer details from PDP
#    Click Add To Cart Button from PDP
#    Click on My Bag
#    Check shipping method group title in minicart  delivery
#    Check ring sizer details in miniCart
#    Click on View Bag from minicart
#    Check shipping method icon  Delivery
#    Compare item details in cart for ring sizer
#    Verify order summary in correct in cart page for ring sizer
#    Verify payment page shipping information   ${Default_Delivery_Method}
#    Verify order summary in payment page for ring sizer
#    Click paypal checkout from cart
#    Log into PayPal
#    On Paypal Account click on Save and Continue
#    Click on Place Order CTA for payment    paypal
##    Enter cvv number  ${Newuser_CardCvv}
##    Click on Place Order CTA for payment    cc
#    Order Confirmation page is displayed for registered user
#    Verify shipping address in order confirmation page   ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
#    Verify billing address in order confirmation page    ${FIRST_NAME}   ${LAST_NAME}  ${Newuser_StreetAddress}  ${Newuser_Flat}  ${Newuser_City}  ${Newuser_State}  ${Newuser_Zipcode}  ${Newuser_Phone}
#    Verify payment method CC in order confirmation page  ${FIRST_NAME} ${LAST_NAME}  ${Newuser_CardType}  ${Newuser_CardNumberMasked}  3/30
#    Verify order details section in confirmation page for ring sizer
#    Go to home page
#    Go to Accounts    Orders & Returns
#    Check that the last order id is present in Order History


