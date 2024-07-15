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
Resource          ../../Keywords/Search.robot

*** Test Cases ***
01 - Search / Product name and Best Match Sort
  [Tags]  search  plp  bms
  @{query_list}=    Create List    Curb Chain Bracelet   Cable Bracelet   Pendant Necklace
  FOR    ${search_query}    IN    @{query_list}
    Search for a product from header search    ${search_query}
    Check did you mean suggestion is not displayed
    Check search instead option for    ${search_query}
    Check top results displayed for search  ${search_query}
    Click View all products
    Check all products in PLP search results contain  ${search_query}
  END


02 - Search / Product partial name and Best Match Sort
  [Tags]  search  plp  partial
  @{query_list}=    Create List    curb   brace   neck
  FOR    ${search_query}    IN    @{query_list}
    Search for a product from header search    ${search_query}
    Check did you mean suggestion for    ${search_query}
    Check search instead option for    ${search_query}
    Check top results displayed for search  ${search_query}
    Click View all products
    Close the Get the First Look modal
    Check all products in PLP search results contain  ${search_query}
  END

03 - Search / Product Style
    [Tags]  search  plp  prodstyle
    Search for a product from header search    D25358MSSABD
    Check did you mean suggestion is not displayed
    Check search instead option for  D25358MSSABD
    Click search icon from header search
    Close the Get the First Look modal
    Verify search result items count  D25358MSSABD
    Check value in PLP search box  D25358MSSABD
    Open the Product from PLP product list  1
    Sleep  1s
    Check product style    D25358MSSABD


04 - Search / Product UPC
    [Tags]  search  plp
    Search for a product from header search  192740978661
    Check did you mean suggestion is not displayed
    Check search instead option for  192740978661
    Click search icon from header search
    Close the Get the First Look modal
    Verify search result items count  192740978661
    Check value in PLP search box  192740978661
    Open the Product from PLP product list  1
    Sleep  2s
    Check product UPC    192740978661

05 - Search / Navigate to PLP from Did you mean option
    [Tags]  search  plp
    Search for a product from header search  gold
    Check did you mean suggestion for  gold
    Capture did you mean suggestion
    Click did you mean suggestion
    Close the Get the First Look modal
    Check value in PLP search box  ${actual_did_you_mean_phrase}
    Check all products in PLP search results contain  ${actual_did_you_mean_phrase}

06 - Check lazy loading
  [Tags]  search  plp  laz
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Check Lazy Loading

07 - Navigation of all category products
  [Tags]  search  plp
  Check category link  womens
  Close the Get the First Look modal
  Check category link  mens
  Check category link  whats-new
  Check category link  gifts
  Check category link  high-jewelry
  Check category link  wedding
  Check category link  world-of-yurman

08 - Blank search
  [Tags]  search  plp
  Search for a product from header search   qwertyui
  Click search icon from header search
  Close the Get the First Look modal
  Verify no results found page
  Check customer care link


09 - Search item from no results page
  [Tags]  search  plp  nrp
  Search for a product from header search    ww
  Click search icon from header search
  Close the Get the First Look modal
  Sleep  1s
  Search item from no results page   D25358MSSABD
  Open the Product from PLP product list  1
  Sleep  1s
  Check product style    D25358MSSABD


10 - Search for Gift Card
  [Tags]  search  plp
  Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
  Search for a product from header search    Gift Card
  Click View all products
  Check Gift card page location

11 - Sort product from price low to high
  [Tags]  sort  plp
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Sort item by  Price Low To High
  Sleep  1s
  Check Products are sorted by Price low to high

12 - Sort product from price high to low
  [Tags]  sort  plp
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Sort item by  Price High to Low
  Sleep  1s
  Check Products are sorted by Price high to low

13 - Sort product for best sellers
  [Tags]  sort  plp
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Sort item by  Best Sellers
  Run Keyword And Ignore Error  Check Products all products contains best seller tags

13 - Filter functions validation
    [Tags]   filter  plp  filfun
    Search for a product from header search    diamond
    Click search icon from header search
    Close the Get the First Look modal
    Filter item by price range  0-749.99
    Filter item by price range  750-1499.99
    Click on clear all button on header for applied filters and validate the filters are removed

14 - Filter product with price range
  [Tags]  filter  plp  pricerange
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Filter item by price range  750-1499.99
  Check if products are filtered with price range  750-1499.99
  Click on x icon on header for applied filter and validate the filter is removed




