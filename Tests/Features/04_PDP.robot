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
01-Check PDP for Rings/Womens
    [Tags]  pdp
    Navigate to Category    womens
    Navigate and click on Subcategory   rings
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list    1
    Capture item details from PDP
    Check pdp bread crumbs are displayed  Women’s  Rings
    Check if product name and sub title is displayed
    Check if product price is displayed
    Check currency of product price in PDP
    Save the product title on PDP
    Save the product subtitle on PDP
    Compare the price from PLP to the one from PDP
    Check if size selector is displayed
    Check size guide elements  ring
   IF  '${shopLocale}' in ['US']
    Initiate and check order from order ring sizer
   END
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
   IF  '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Click email customer care button
    Check email customer care modal details
    Check email customer care negative validations
    Fill and submit email customer care form with reason and signup   Shipping   yes
    Check if deliver to address radio button is displayed
    Check if deliver to address radio button is selected by default
    Check if pickup from boutique radio button is displayed
    Run Keyword And Warn On Failure  Check affirm link
   ELSE
    Close contact customer care slide out
   END
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if care section is displayed
    Check if gifting section is displayed
    Verify the You May Also Like carousel
    Verify the Explore More From This Collection carousel
    Verify the Trending Now carousel
    Click on Wish icon from PDP
    Access the Wishlist page
    Verify if the previously added product from PDP is displayed on Wishlist page


02-Check PDP for mens bracelet
    [Tags]  pdp
    Navigate to Category    mens
    Navigate and click on Subcategory   bracelets
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list    1
    Capture item details from PDP
    Check pdp bread crumbs are displayed  Men's  Bracelets
    Check if product name and sub title is displayed
    Check if product price is displayed
    Check currency of product price in PDP
    Save the product title on PDP
    Save the product subtitle on PDP
    Compare the price from PLP to the one from PDP
    Check if size selector is displayed
    Check size guide elements  bracelet
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
   IF  '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Click email customer care button
    Check email customer care modal details
    Fill and submit email customer care form with reason and signup   Returns/Exchanges   no
    Check if deliver to address radio button is displayed
    Check if deliver to address radio button is selected by default
    Check if pickup from boutique radio button is displayed
    Check affirm link
   ELSE
    Close contact customer care slide out
   END
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if care section is displayed
    Check if gifting section is displayed
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

03-Check PDP for womens necklace
    [Tags]  pdp
    Navigate to Category    womens
    Navigate and click on Subcategory   necklaces
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list    1
    Capture item details from PDP
    Check pdp bread crumbs are displayed  Women's  Necklaces
    Check if product name and sub title is displayed
    Check if product price is displayed
    Check currency of product price in PDP
    Save the product title on PDP
    Save the product subtitle on PDP
    Compare the price from PLP to the one from PDP
    Check if size selector is displayed
    Check size guide elements  necklace
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
   IF  '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Click email customer care button
    Check email customer care modal details
    Fill and submit email customer care form with reason and signup   Repairs   yes
    Check if deliver to address radio button is displayed
    Check if deliver to address radio button is selected by default
    Check if pickup from boutique radio button is displayed
    Check affirm link
   ELSE
    Close contact customer care slide out
   END
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if care section is displayed
    Check if gifting section is displayed
    Verify the You May Also Like carousel
    Verify the Explore More From This Collection carousel
    Verify the Trending Now carousel
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

04-Check PDP for womens earrings
    [Tags]  pdp
    Search for a product from header search  earrings
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list  2
    Capture item details from PDP
    Check pdp bread crumbs are displayed  Women's  Earrings
    Check if product name and sub title is displayed
    Check if product price is displayed
    Check currency of product price in PDP
    Save the product title on PDP
    Save the product subtitle on PDP
    Compare the price from PLP to the one from PDP
    Check whether size guide is not visible
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
   IF  '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Click email customer care button
    Check email customer care modal details
    Fill and submit email customer care form with reason and signup   International   yes
    Check if deliver to address radio button is displayed
    Check if deliver to address radio button is selected by default
    Check if pickup from boutique radio button is displayed
    Check affirm link
   ELSE
    Close contact customer care slide out
   END
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if care section is displayed
    Check if gifting section is displayed
    Verify the You May Also Like carousel
    Verify the Explore More From This Collection carousel
    Verify the Trending Now carousel
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

05-Check PDP for Virtual Gift Card
    [Tags]  pdp  gc
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  Virtual Gift Card
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list  1
    Capture item details from PDP - VGC
    Check gift card bread crumbs are displayed
    Check virtual gift card pdp elements
    Check validation messages in virtual gift card pdp
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
   IF  '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Click email customer care button
    Check email customer care modal details
    Fill and submit email customer care form with reason and signup   Wedding/Bridal   yes
   ELSE
    Close contact customer care slide out
   END
    Check if add to wishlist list button is displayed
    Check if details section is displayed
    Check if details is opened is default
    Fill Virtual GC PDP
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

06-Check PDP for Physical Gift Card
    [Tags]  pdp  gc
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search   Gift Card
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
#    Open the PDP with nth number from PLP product list  1
    Capture item details from PDP - VGC
    Check gift card bread crumbs are displayed
#    Check virtual gift card pdp elements
#    Check validation messages in virtual gift card pdp
    Check if add to cart button is displayed
#    Check validation messages in virtual gift card pdp
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
   IF  '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Click email customer care button
    Check email customer care modal details
    Fill and submit email customer care form with reason and signup   General Inquiry   yes
   ELSE
    Close contact customer care slide out
   END
    Check if add to wishlist list button is displayed
    Check if details section is displayed
    Check if details is opened is default
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

07-Check PDP for Ring Sizer
    [Tags]  pdp
    Skip If   '${shopLocale}' in ['UK','FR','GR','IT','CN']
    Search for a product from header search  ring sizer
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list   1
    Check pdp bread crumbs are displayed for ring sizer
    Check if product name and sub title is displayed for ring sizer
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
    Click email customer care button
    Check email customer care modal details
    Close email customer modal
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if gifting section is displayed
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

08-Check PDP for Pre-order
    [Tags]  pdp  preor
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  earrings
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list  1
    Capture item details from PDP
    Check pdp bread crumbs are displayed  Women's  Earrings
    Check if product name and sub title is displayed
    Check if product price is displayed
    Check currency of product price in PDP
    Save the product title on PDP
    Save the product subtitle on PDP
    Compare the price from PLP to the one from PDP
    Check whether size guide is not visible
    Check if preorder button is displayed
    Check if contact customer care button is displayed
    Click contact customer care button
    Check contact customer care modal details
    Check schedule consultation
    Click email customer care button
    Close email customer modal
    Check if deliver to address radio button is displayed
    Check if deliver to address radio button is selected by default
    Check if not available for pickup from boutique radio button is displayed
    Run Keyword And Warn On Failure  Check affirm link
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if care section is displayed
    Check if gifting section is displayed
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

09-Check PDP for out of stock product
    [Tags]  pdp
    Search for a product from header search  R07437+S8
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list  1
    Select Size    5
    Check if a product with no stock is displayed correctly
   IF  '${shopLocale}' in ['US', 'CN']
    Generate Timestamp Email
    Click on Notify Me button
    Fill in the Notify Me form    ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Submit the Notify Me form and check the result
   END

10-Check navigations and other functionalities from PDP
    [Tags]  pdp  pdpnav
    Search for a product from header search  D16903 88
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list  1
    Capture item details from PDP
    Check Navigation from Collections link
    Go Back
    Click on image nr from PDP image gallery    1
    Swipe to last image (on PDP image gallery)
    Click on Zoom icon from PDP image gallery
    Click on Close icon from PDP image gallery
   IF  '${shopLocale}' in ['US', 'CN']
    Click on Pick up at David Yurman boutique
    Fill in the Zip and Distance on Pickup In Store modal    ${store_zipCode}    100
    Click on Search from Pickup In Store modal
    Click on Select This Store for available store nr    1
    Check that the selected store appears on PDP pick up
    Search for a product from header search  R07437+S8
    Click search icon from header search
    Open the Product from PLP product list  1
    Check Not avaialble in saved store location is displayed
   END

11-Check PDP for product with gem stone care
    [Tags]  pdp
    Search for a product from header search  192740672491
    Click search icon from header search
    Close the Get the First Look modal
    Sleep  2s
    Open the PDP with nth number from PLP product list  1
    Capture item details from PDP
    Check pdp bread crumbs are displayed  Women's  Rings
    Check if product name and sub title is displayed
    Check if product price is displayed
    Check currency of product price in PDP
    Save the product title on PDP
    Save the product subtitle on PDP
    Compare the price from PLP to the one from PDP
    Check if add to cart button is displayed
    Check if contact customer care button is displayed
    Check if add to wishlist list button is displayed
    Check if complimentary links are displayed
    Check if details section is displayed
    Check if details is opened is default
    Check if care section is displayed
    Check if Gem stone care and metal care are diplayed in care section
    Check if gifting section is displayed
#    Click on Wish icon from PDP
#    Access the Wishlist page
#    Verify if the previously added product from PDP is displayed on Wishlist page

12-Check PDP for Men's high jewelry
    [Tags]  PDP  mhj  CCMS-6443
    Navigate to Category    high-jewelry
    Navigate to subcategory in high-jewelry  mens-high-jewelry
    Capture title of nth product on high-jewelry PLP  3
    Click on nth product on high-jewelry PLP  3
    Capture item details from PDP in high-jewelry
    Check pdp bread crumbs are displayed   Men's   Pendants
    Compare titles from PLP in high jewelry PDP
    Verfiy the message below contact specialist button
    Check if Details is opened is default
    Check if care section is displayed
    Check if metal care is displayed in care section in high-jewelry
    Click contact product specialist
    Expected elements in contact product specialist modal
    Fill and submit Contact a product specialist form

13-Check PDP for Womens's high jewelry
    [Tags]  PDP  mhjw  CCMS-6443
    Navigate to Category    high-jewelry
    Navigate to subcategory in high-jewelry  womens-high-jewelry
    Capture title of nth product on high-jewelry women PLP  1
    Click on nth product on high-jewelry women PLP  1
    Capture item details from PDP in high-jewelry
    Check pdp bread crumbs are displayed   Women's   Earrings
    Compare titles from PLP in high jewelry PDP
    Verfiy the message below contact specialist button
    Check if Details is opened is default
    Check if care section is displayed
    Click contact product specialist
    Expected elements in contact product specialist modal
    Fill and submit Contact a product specialist form

14-Check PDP for wedding-Engagement rings
    [Tags]  PDP  wer  CCMS-6443
    Navigate to Category  wedding
    Mouse Click    id=engagement-rings
    Close the Get the First Look modal
    Capture nth item title from PLP  1
    Open the Product from PLP product list  1
    Capture item details from PDP in high-jewelry
    Check pdp bread crumbs are displayed  Wedding  Engagement Rings
    Compare the PLP product details with PDP
    Verfiy the message below contact specialist button
    Check if Details is opened is default
    Check if care section is displayed
    Check if metal care is displayed in care section in high-jewelry
    Click contact diamond specialist
    Expected elements in contact diamond specialist modal
    Fill and submit Contact a diamond specialist form





##PDP CHECK FOR CHARMS AND AMULETS