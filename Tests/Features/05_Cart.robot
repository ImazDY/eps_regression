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
01-Verfiy Actions from cart page
    [Tags]  cart
    Add multiple products to the cart    B11278 S8=S    B11278 S8s=M
    Click on My Bag
    Click on View Bag from minicart
    Check the elements of the Cart page
    Click on first Edit link from Cart
    Modify the Size of the first product from the cart    L
    Click on Update button from Update Product modal
    Verify if the size was modified in the Cart
    Click on Move to Wishlist link from the Cart and verify if the product was added to Wishlist
    Remove the first item from the Cart
    Remove all products from the Cart
    Check empty Cart message
    Open PDP for product with id    B11278 S8
    Select Size    S
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Update the quantity of the first item from the Cart
    Click on Checkout button from Cart page
    Expand the Promo Code section
    Enter a valid promo code    Product
    Click on Add Promo Code button
    Verify the successful promo code message
    Return to Cart
    Check affirm link
    Click on My Bag
    Check Minicart elements
    Check if product price and total price is correct
#    Check Info Texts During Checkout

02-Check cart elements with delivery item in bag
    [Tags]  cart
    Search for a product from header search  B11278 S8
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    S
    Capture item details from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Verify whether delivery type for item is displayed in cart  Delivery
    Compare item details in cart with minicart  Delivery   5
    Verify order summary in correct in cart page

03-Check cart elements with BOPIS item in bag
    [Tags]  cart
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  R15752MBB
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size     6
    Capture item details from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Open BOPIS modal
    Select available store at       ${store_zipCode}
    Get store location shown with product
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Check shipping method icon  Pick up
    Verify whether delivery type for item is displayed in cart  Pick up
    Compare item details in cart with minicart  pick up   6
    Verify order summary in correct in cart page

04-Check cart elements with Pre order item in bag
    [Tags]  cart
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  R15752MBB
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size     6
    Capture item details from PDP
    Save the product subtitle on PDP
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Check shipping method icon  Pre-Order
    Verify whether delivery type for item is displayed in cart  Pre-Order
    Compare item details in cart with minicart   pre order    6
    Verify order summary in correct in cart page
