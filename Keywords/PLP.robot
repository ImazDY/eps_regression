*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot

*** Keywords ***
Open the PDP with nth number from PLP product list
    [Arguments]    ${nr}
    @{pdp_open_from_plp}    Create List
    Wait Until Element Is Visible    (${plp_itemsList_l})[${nr}]     20s     error=Product Tile is not visible
    ${text}    Get Text    xpath:(//a[contains(@class, 'pdp-link')]//p)[${nr}]
    Append To List  ${pdp_open_from_plp}  ${text}
    #get the product price
    ${range_available}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//a[contains(@class, 'pdp-link')]//div)[${nr}]//span[@class='range']     20s
    IF    "${range_available}" == "True"
        ${range_1}    Get Text    xpath:((//a[contains(@class, 'pdp-link')]//div)[${nr}]//span[@class='range']//span//span//span[@class='value'])[1]
        ${range_2}    Get Text    xpath:((//a[contains(@class, 'pdp-link')]//div)[${nr}]//span[@class='range']//span//span//span[@class='value'])[2]
        ${plp_product_price_if}   Get Text   xpath:(//a[contains(@class, 'pdp-link')]//div)[${nr}]//span[@class='range']
    ELSE
        ${plp_product_price_if}    Get Text    xpath:(//a[contains(@class, 'pdp-link')]//div)[${nr}]//span[contains(@class,'tile-price')]
    END
    ${plp_product_price_if}   Remove currency and comma from price    ${plp_product_price_if}
    Set Test Variable    ${plp_product_price}    ${plp_product_price_if}

    Set Test Variable  ${pdp_open_from_plp}
#    Mouse Over   (//div[contains(@class, 'tile-body')])[${nr}]
    Center Element on Screen    (${plp_itemsList_l})[${nr}]
    Set Focus To Element    (${plp_itemsList_l})[${nr}]
    Click Element    xpath:(${plp_itemsList_l})[${nr}]
    Wait Until Page Contains Element    ${pdp_product_show_l}     10s     error=Product Page is not entirely loaded

Capture nth item title from PLP
    [Arguments]  ${nth}
    Wait Until Element Is Visible    (//a[contains(@class, 'pdp-link')]//p)[${nth}]  10s
#    Scroll To Element    (//div[contains(@class, 'pdp-link')])[${nth}]//a[1]
    ${PLP_product_title}    Get Text   (//a[contains(@class, 'pdp-link')]//p)[${nth}]
#    ${PLP_product_subtitle}  Get Text   (//div[contains(@class, 'pdp-link')])[${nth}]//a[2]
    Set Test Variable  ${PLP_product_title}
#    Set Test Variable  ${PLP_product_subtitle}
    

Add first number of products to wishlist from PLP
    [Arguments]    ${nr}
    Close the Get the First Look modal
    ${added_to_wishlist}    Create List
    FOR    ${nr_i}    IN RANGE    1    ${nr}+1
        Wait Until Element Is Visible    xpath:(//*[contains(@class,'js-tile-image plp-carosel')])[${nr_i}]    10s     error=First Product Tile is not visible
        Execute JavaScript    window.scrollTo(0, 300);
        Sleep  2s
        Mouse Over    xpath:(//*[contains(@class,'js-tile-image plp-carosel')])[${nr_i}]
#        Scroll Element Into View    xpath:(//*[@title='Wishlist'])[${nr_i}]
        Click Element    xpath:(//*[contains(@class,'icon-heart')])[${nr_i}]
#        Mouse Over    (//div[contains(@class, 'tile-body')])[${nr_i}]//*[@class='pdp-link']
#        Wait Until Element Is Visible    xpath:(//div[contains(@class, 'tile-body')])[${nr_i}]//*[@class='pdp-link']/parent::*/preceding-sibling::*//button[1]//*[2]    10s     error=Red Heart icon is not visible
        ${text}    Get Text    (//a[contains(@class, 'pdp-link')]//p)[${nr_i}]
        Append To List    ${added_to_wishlist}    ${text}
    END
    Set Test Variable    ${added_to_wishlist}


Open the Product from PLP product list
    [Arguments]    ${nr}
    Wait Until Element Is Visible    xpath:(//*[contains(@class,'js-tile-image plp-carosel')])[${nr}]     40s     error=Product Tile is not visible
    Mouse Click    xpath:(//*[contains(@class,'js-tile-image plp-carosel')])[${nr}]
    Wait Until Page Contains Element    xpath:(//span[contains(@class,'product-name')])[1]     20s     error=Product Page is not entirely loaded

Check product style
   [Arguments]  ${style}
   Wait Until Element Is Visible  (//li[@class='product-style-number'])[1]  10s
   Scroll To Element    xpath:(//li[@class='product-style-number'])[1]
   Element Should Contain    xpath:(//li[@class='product-style-number'])[1]    Style #${style}

Check value in PLP search box
     [Arguments]    ${search_value}
     ${attribute_value}=    Get Element Attribute    xpath:(//form[@role='search']/input)[2]    value
     Should Contain Text    ${attribute_value}    ${search_value}

Check product UPC
   [Arguments]  ${UPC}
   Scroll To Element    xpath:(//li[@class='upc'])[1]
   Sleep  1s
   Element Text Should Be    xpath:(//li[@class='upc'])[1]     UPC ${UPC}

Click on Filter
    Wait Until Page Contains Element  ${filters_showBtn}  10s
    Click By JS     ${filters_showBtn}

Verify all filters listed
    @{filterelements}  Create List  ${filters_hideBtn}  ${filters_type}  ${filters_price}
    ...  ${filters_material}  ${filters_gemColor}  ${filters_gemType}
    ...  ${filters_collection}  ${filters_size}
    Wait Until Page Contains Multiple Elements  @{filterelements}

Hide the filter
    Wait Until Page Contains Element  ${filters_hideBtn}  10s
    Click By JS     ${filters_hideBtn}

Click First Product recommendation
      Wait Until Element Is Visible    (//div[contains(@class,'ymal-tile-image')]//parent::a)[1]  10s  
      Center Element on Screen      (//div[contains(@class,'ymal-tile-image')]//parent::a)[1]
      Click Element    (//div[contains(@class,'ymal-tile-image')]//parent::a)[1]
