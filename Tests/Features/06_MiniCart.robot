*** Settings ***
Test Setup        Run Keywords    Open website  Read Data From JSON File  Close dev tools icon
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
Resource          ../../Keywords/Search.robot
Resource          ../../Keywords/MiniCart.robot

*** Test Cases ***
01 - Check empty minicart elements
    [Tags]  minicart
    Click on My Bag
    Verify whether title is displayed in empty guest minicart
    Verify whether shopping bag empty message is displayed
    Verify whether women and men toggle is displayed
    Verify whether shop by rails are displayed
    Verify whether trending now rails are displayed
    Verify by default women is selected

02 - Check navigation from empty minicart for guest user
    [Tags]  minicart
    Navigate to Category  high-jewelry
    Click on My Bag
    Verify navigation from shop braclets for women
    Click on My Bag
    Verify whether user can toggle to men
    Verify whether the shop by rails changes to men
    Verify whether user can toggle to women
    Verify whether the shop by rails changes to women
#    Verify whether user navigates to correct PLP page from trending now


03 - Check minicart elements with delivery item in bag
    [Tags]  minicart
    Search for a product from header search  ${Delivery_product}
    Click search icon from header search
    Close the Get the First Look modal
    Open the PDP with nth number from PLP product list    1
    Select Size    ${Delivery_productSize}
    Capture item details from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Verify whether title is displayed in guest minicart
    Verify whether item count is displayed in minicart  1
    Verify whether delivery type for item is displayed in minicart  Delivery
    Compare item details in minicart with PDP  5
    Verify whether remove button is displayed for the product
    Verify whether quantity selector is displayed for the product
    Verify whether discover more rails are displayed
    Verify minicart buttons
    Remove a product from cart and verify remove success message



04 - Check minicart elements with pre order item in bag
    [Tags]  minicart  preorm
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  192740636189
    Click search icon from header search
    Close the Get the First Look modal
    Open the PDP with nth number from PLP product list    1
    Select Size    XS
    Capture item details from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Pre order Button from PDP
    Verify whether title is displayed in guest minicart
    Verify whether item count is displayed in minicart  1
    Verify whether delivery type for item is displayed in minicart  Pre-Order
    Compare item details in minicart with PDP  XS
    Verify whether remove button is displayed for the product
    Verify whether quantity selector is displayed for the product
    Verify whether discover more rails are displayed
    Verify minicart buttons


05 - Check minicart elements with BOPIS item in bag
    [Tags]  minicart
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  CH0100 S416
    Click search icon from header search
    Close the Get the First Look modal
    Open the PDP with nth number from PLP product list    1
    Select Size     18
    Capture item details from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Open BOPIS modal
    IF    '${shopLocale}' in ['US']
    Select available store at       92626
    END
    IF    '${shopLocale}' in ['CN']
    Select available store at       M6A 2T9
    END
    Get store location shown with product
    Click Add To Cart Button from PDP
    Verify whether title is displayed in guest minicart
    Verify whether item count is displayed in minicart  1
    Verify whether delivery type for item is displayed in minicart  Pick up
    Compare item details in minicart with PDP  6
    Verify whether remove button is displayed for the product
    Verify whether quantity selector is displayed for the product
    Verify whether discover more rails are displayed
    Verify minicart buttons
    Increase the nth product count by n  1  1
    Decrease the nth product count by n  1  1
    Make sure product is still in the cart after decrease in quantity



06 - Check button actions from minicart
    [Tags]  minicart  i2
    Search for a product from header search  883932208184
    Click search icon from header search
    Close the Get the First Look modal
    Open the PDP with nth number from PLP product list    1
    Select Size    7
    Sleep  2s
    Capture item details from PDP
    Click Add To Cart Button from PDP
    Verify navigation to PDP from mini cart
    Click Add To Cart Button from PDP
    Verify navigation from view bag button
    Click on My Bag
    Verify navigation from continue checkout button
    Click Back to bag button from checkout page
    Click on My Bag
    Verify quantity selector functionality
    Verify validation messages for item not available in minicart
    IF    '${shopLocale}' in ['US','CN']
#    Click on My Bag
    Verify navigation from paypal
    END







