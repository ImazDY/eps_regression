*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           Collections
Library           OperatingSystem
Library           XML
Library           DateTime
Library           String
Library           random
Library           OperatingSystem
Library           JSONLibrary

Resource          ../Resources/Variables.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/LamdaTestSetup.robot

*** Keywords ***
Read Data From JSON File
  IF  '${shopLocale}' in ['US']
     ${file}   Load Json From File       Resources/DataFiles/USData.json
   ELSE IF  '${shopLocale}' in ['CN']
     ${file}   Load Json From File       Resources/DataFiles/CNData.json
   ELSE IF  '${shopLocale}' in ['UK']
     ${file}   Load Json From File       Resources/DataFiles/UKData.json
   ELSE IF  '${shopLocale}' in ['FR']
     ${file}   Load Json From File       Resources/DataFiles/FRData.json
   ELSE IF  '${shopLocale}' in ['GR']
     ${file}   Load Json From File       Resources/DataFiles/GRData.json
   ELSE IF  '${shopLocale}' in ['IT']
     ${file}   Load Json From File       Resources/DataFiles/ITData.json
  END

   ${Country}    Get Value From Json    ${file}    $.Country
   ${Country}    Convert To String      ${Country}
   ${Country}    Get Clear DATA         ${Country}
   ${Country}    Set Test Variable      ${Country}
   
   ${Currency}    Get Value From Json    ${file}    $.Currency
   ${Currency}    Convert To String      ${Currency}
   ${Currency}    Get Clear DATA         ${Currency}
   ${Currency}    Set Test Variable      ${Currency}
   
   ${Default_Delivery_Method}    Get Value From Json    ${file}    $.Default_Delivery_Method
   ${Default_Delivery_Method}    Convert To String      ${Default_Delivery_Method}
   ${Default_Delivery_Method}    Get Clear DATA         ${Default_Delivery_Method}
   ${Default_Delivery_Method}    Set Test Variable      ${Default_Delivery_Method}
   
   ${Delivery_product}    Get Value From Json    ${file}    $.Delivery_product
   ${Delivery_product}    Convert To String      ${Delivery_product}
   ${Delivery_product}    Get Clear DATA         ${Delivery_product}
   ${Delivery_product}    Set Test Variable      ${Delivery_product}
   
   ${Delivery_productSize}    Get Value From Json    ${file}    $.Delivery_productSize
   ${Delivery_productSize}    Convert To String      ${Delivery_productSize}
   ${Delivery_productSize}    Get Clear DATA         ${Delivery_productSize}
   ${Delivery_productSize}    Set Test Variable      ${Delivery_productSize}
   
   ${Delivery_product_2}    Get Value From Json    ${file}    $.Delivery_product_2
   ${Delivery_product_2}    Convert To String      ${Delivery_product_2}
   ${Delivery_product_2}    Get Clear DATA         ${Delivery_product_2}
   ${Delivery_product_2}    Set Test Variable      ${Delivery_product_2}
   
   ${Delivery_productSize_2}    Get Value From Json    ${file}    $.Delivery_productSize_2
   ${Delivery_productSize_2}    Convert To String      ${Delivery_productSize_2}
   ${Delivery_productSize_2}    Get Clear DATA         ${Delivery_productSize_2}
   ${Delivery_productSize_2}    Set Test Variable      ${Delivery_productSize_2}
   
   ${BOPIS_product}    Get Value From Json    ${file}    $.BOPIS_product
   ${BOPIS_product}    Convert To String      ${BOPIS_product}
   ${BOPIS_product}    Get Clear DATA         ${BOPIS_product}
   ${BOPIS_product}    Set Test Variable      ${BOPIS_product}
   
   ${BOPIS_productSize}    Get Value From Json    ${file}    $.BOPIS_productSize
   ${BOPIS_productSize}    Convert To String      ${BOPIS_productSize}
   ${BOPIS_productSize}    Get Clear DATA         ${BOPIS_productSize}
   ${BOPIS_productSize}    Set Test Variable      ${BOPIS_productSize}
   
   ${BOPIS_product_2}    Get Value From Json    ${file}    $.BOPIS_product_2
   ${BOPIS_product_2}    Convert To String      ${BOPIS_product_2}
   ${BOPIS_product_2}    Get Clear DATA         ${BOPIS_product_2}
   ${BOPIS_product_2}    Set Test Variable      ${BOPIS_product_2}
   
   ${BOPIS_productSize_2}    Get Value From Json    ${file}    $.BOPIS_productSize_2
   ${BOPIS_productSize_2}    Convert To String      ${BOPIS_productSize_2}
   ${BOPIS_productSize_2}    Get Clear DATA         ${BOPIS_productSize_2}
   ${BOPIS_productSize_2}    Set Test Variable      ${BOPIS_productSize_2}
   
   ${Preorder_product}    Get Value From Json    ${file}    $.Preorder_product
   ${Preorder_product}    Convert To String      ${Preorder_product}
   ${Preorder_product}    Get Clear DATA         ${Preorder_product}
   ${Preorder_product}    Set Test Variable      ${Preorder_product}
   
   ${Preorder_productSize}    Get Value From Json    ${file}    $.Preorder_productSize
   ${Preorder_productSize}    Convert To String      ${Preorder_productSize}
   ${Preorder_productSize}    Get Clear DATA         ${Preorder_productSize}
   ${Preorder_productSize}    Set Test Variable      ${Preorder_productSize}

   ${store_expected_address}    Get Value From Json    ${file}    $.store_expected_address
   ${store_expected_address}    Convert To String      ${store_expected_address}
   ${store_expected_address}    Get Clear DATA         ${store_expected_address}
   ${store_expected_address}    Set Test Variable      ${store_expected_address}

   ${store_expected_city_state}    Get Value From Json    ${file}    $.store_expected_city_state
   ${store_expected_city_state}    Convert To String      ${store_expected_city_state}
   ${store_expected_city_state}    Get Clear DATA         ${store_expected_city_state}
   ${store_expected_city_state}    Set Test Variable      ${store_expected_city_state}

   ${store_expected_phone_number}    Get Value From Json    ${file}    $.store_expected_phone_number
   ${store_expected_phone_number}    Convert To String      ${store_expected_phone_number}
   ${store_expected_phone_number}    Get Clear DATA         ${store_expected_phone_number}
   ${store_expected_phone_number}    Set Test Variable      ${store_expected_phone_number}

   ${store_zipCode}    Get Value From Json    ${file}    $.store_zipCode
   ${store_zipCode}    Convert To String      ${store_zipCode}
   ${store_zipCode}    Get Clear DATA         ${store_zipCode}
   ${store_zipCode}    Set Test Variable      ${store_zipCode}
   
   ${store_zipCode_2}    Get Value From Json    ${file}    $.store_zipCode_2
   ${store_zipCode_2}    Convert To String      ${store_zipCode_2}
   ${store_zipCode_2}    Get Clear DATA         ${store_zipCode_2}
   ${store_zipCode_2}    Set Test Variable      ${store_zipCode_2}

   ${NewUser_CardNumber}    Get Value From Json    ${file}    $.NewUser_CardNumber
   ${NewUser_CardNumber}    Convert To String      ${NewUser_CardNumber}
   ${NewUser_CardNumber}    Get Clear DATA         ${NewUser_CardNumber}
   ${NewUser_CardNumber}    Set Test Variable      ${NewUser_CardNumber}
   
   ${NewUser_CardNumberMasked}    Get Value From Json    ${file}    $.NewUser_CardNumberMasked
   ${NewUser_CardNumberMasked}    Convert To String      ${NewUser_CardNumberMasked}
   ${NewUser_CardNumberMasked}    Get Clear DATA         ${NewUser_CardNumberMasked}
   ${NewUser_CardNumberMasked}    Set Test Variable      ${NewUser_CardNumberMasked}
   
   ${NewUser_CardType}    Get Value From Json    ${file}    $.NewUser_CardType
   ${NewUser_CardType}    Convert To String      ${NewUser_CardType}
   ${NewUser_CardType}    Get Clear DATA         ${NewUser_CardType}
   ${NewUser_CardType}    Set Test Variable      ${NewUser_CardType}
   
   ${NewUser_CardExp}    Get Value From Json    ${file}    $.NewUser_CardExp
   ${NewUser_CardExp}    Convert To String      ${NewUser_CardExp}
   ${NewUser_CardExp}    Get Clear DATA         ${NewUser_CardExp}
   ${NewUser_CardExp}    Set Test Variable      ${NewUser_CardExp}
   
   ${NewUser_CardExpYear}    Get Value From Json    ${file}    $.NewUser_CardExpYear
   ${NewUser_CardExpYear}    Convert To String      ${NewUser_CardExpYear}
   ${NewUser_CardExpYear}    Get Clear DATA         ${NewUser_CardExpYear}
   ${NewUser_CardExpYear}    Set Test Variable      ${NewUser_CardExpYear}
   
   ${NewUser_CardCvv}    Get Value From Json    ${file}    $.NewUser_CardCvv
   ${NewUser_CardCvv}    Convert To String      ${NewUser_CardCvv}
   ${NewUser_CardCvv}    Get Clear DATA         ${NewUser_CardCvv}
   ${NewUser_CardCvv}    Set Test Variable      ${NewUser_CardCvv}
   
   ${GiftCard_Recipient_FirstName}    Get Value From Json    ${file}    $.GiftCard_Recipient_FirstName
   ${GiftCard_Recipient_FirstName}    Convert To String      ${GiftCard_Recipient_FirstName}
   ${GiftCard_Recipient_FirstName}    Get Clear DATA         ${GiftCard_Recipient_FirstName}
   ${GiftCard_Recipient_FirstName}    Set Test Variable      ${GiftCard_Recipient_FirstName}
   
   ${GiftCard_Recipient_LastName}    Get Value From Json    ${file}    $.GiftCard_Recipient_LastName
   ${GiftCard_Recipient_LastName}    Convert To String      ${GiftCard_Recipient_LastName}
   ${GiftCard_Recipient_LastName}    Get Clear DATA         ${GiftCard_Recipient_LastName}
   ${GiftCard_Recipient_LastName}    Set Test Variable      ${GiftCard_Recipient_LastName}
   
   ${GiftCard_Recipient_Email}    Get Value From Json    ${file}    $.GiftCard_Recipient_Email
   ${GiftCard_Recipient_Email}    Convert To String      ${GiftCard_Recipient_Email}
   ${GiftCard_Recipient_Email}    Get Clear DATA         ${GiftCard_Recipient_Email}
   ${GiftCard_Recipient_Email}    Set Test Variable      ${GiftCard_Recipient_Email}
   
   ${GiftCard_Sender_Name}    Get Value From Json    ${file}    $.GiftCard_Sender_Name
   ${GiftCard_Sender_Name}    Convert To String      ${GiftCard_Sender_Name}
   ${GiftCard_Sender_Name}    Get Clear DATA         ${GiftCard_Sender_Name}
   ${GiftCard_Sender_Name}    Set Test Variable      ${GiftCard_Sender_Name}

   ${FIRST_NAME}    Get Value From Json    ${file}    $.FIRST_NAME
   ${FIRST_NAME}    Convert To String      ${FIRST_NAME}
   ${FIRST_NAME}    Get Clear DATA         ${FIRST_NAME}
   ${FIRST_NAME}    Set Test Variable      ${FIRST_NAME}

   ${LAST_NAME}    Get Value From Json    ${file}    $.LAST_NAME
   ${LAST_NAME}    Convert To String      ${LAST_NAME}
   ${LAST_NAME}    Get Clear DATA         ${LAST_NAME}
   ${LAST_NAME}    Set Test Variable      ${LAST_NAME}

   ${NewUser_Pwd}    Get Value From Json    ${file}    $.NewUser_Pwd
   ${NewUser_Pwd}    Convert To String      ${NewUser_Pwd}
   ${NewUser_Pwd}    Get Clear DATA         ${NewUser_Pwd}
   ${NewUser_Pwd}    Set Test Variable      ${NewUser_Pwd}
   
   ${NewUser_StreetAddress}    Get Value From Json    ${file}    $.NewUser_StreetAddress
   ${NewUser_StreetAddress}    Convert To String      ${NewUser_StreetAddress}
   ${NewUser_StreetAddress}    Get Clear DATA         ${NewUser_StreetAddress}
   ${NewUser_StreetAddress}    Set Test Variable      ${NewUser_StreetAddress}
    
   ${NewUser_Flat}    Get Value From Json    ${file}    $.NewUser_Flat
   ${NewUser_Flat}    Convert To String      ${NewUser_Flat}
   ${NewUser_Flat}    Get Clear DATA         ${NewUser_Flat}
   ${NewUser_Flat}    Set Test Variable      ${NewUser_Flat}
    
   ${NewUser_City}    Get Value From Json    ${file}    $.NewUser_City
   ${NewUser_City}    Convert To String      ${NewUser_City}
   ${NewUser_City}    Get Clear DATA         ${NewUser_City}
   ${NewUser_City}    Set Test Variable      ${NewUser_City}
   
   ${NewUser_State}    Get Value From Json    ${file}    $.NewUser_State
   ${NewUser_State}    Convert To String      ${NewUser_State}
   ${NewUser_State}    Get Clear DATA         ${NewUser_State}
   ${NewUser_State}    Set Test Variable      ${NewUser_State}
   
   ${NewUser_Zipcode}    Get Value From Json    ${file}    $.NewUser_Zipcode
   ${NewUser_Zipcode}    Convert To String      ${NewUser_Zipcode}
   ${NewUser_Zipcode}    Get Clear DATA         ${NewUser_Zipcode}
   ${NewUser_Zipcode}    Set Test Variable      ${NewUser_Zipcode}
   
   ${NewUser_Phone}    Get Value From Json    ${file}    $.NewUser_Phone
   ${NewUser_Phone}    Convert To String      ${NewUser_Phone}
   ${NewUser_Phone}    Get Clear DATA         ${NewUser_Phone}
   ${NewUser_Phone}    Set Test Variable      ${NewUser_Phone}

   ${FIRST_NAME_EDITED}    Get Value From Json    ${file}    $.FIRST_NAME_EDITED
   ${FIRST_NAME_EDITED}    Convert To String      ${FIRST_NAME_EDITED}
   ${FIRST_NAME_EDITED}    Get Clear DATA         ${FIRST_NAME_EDITED}
   ${FIRST_NAME_EDITED}    Set Test Variable      ${FIRST_NAME_EDITED}

   ${LAST_NAME_EDITED}    Get Value From Json    ${file}    $.LAST_NAME_EDITED
   ${LAST_NAME_EDITED}    Convert To String      ${LAST_NAME_EDITED}
   ${LAST_NAME_EDITED}    Get Clear DATA         ${LAST_NAME_EDITED}
   ${LAST_NAME_EDITED}    Set Test Variable      ${LAST_NAME_EDITED}

   ${NewUser_StreetAddress_EDITED}    Get Value From Json    ${file}    $.NewUser_StreetAddress_EDITED
   ${NewUser_StreetAddress_EDITED}    Convert To String      ${NewUser_StreetAddress_EDITED}
   ${NewUser_StreetAddress_EDITED}    Get Clear DATA         ${NewUser_StreetAddress_EDITED}
   ${NewUser_StreetAddress_EDITED}    Set Test Variable      ${NewUser_StreetAddress_EDITED}

   ${NewUser_Flat_EDITED}    Get Value From Json    ${file}    $.NewUser_Flat_EDITED
   ${NewUser_Flat_EDITED}    Convert To String      ${NewUser_Flat_EDITED}
   ${NewUser_Flat_EDITED}    Get Clear DATA         ${NewUser_Flat_EDITED}
   ${NewUser_Flat_EDITED}    Set Test Variable      ${NewUser_Flat_EDITED}

   ${NewUser_City_EDITED}    Get Value From Json    ${file}    $.NewUser_City_EDITED
   ${NewUser_City_EDITED}    Convert To String      ${NewUser_City_EDITED}
   ${NewUser_City_EDITED}    Get Clear DATA         ${NewUser_City_EDITED}
   ${NewUser_City_EDITED}    Set Test Variable      ${NewUser_City_EDITED}

   ${NewUser_State_EDITED}    Get Value From Json    ${file}    $.NewUser_State_EDITED
   ${NewUser_State_EDITED}    Convert To String      ${NewUser_State_EDITED}
   ${NewUser_State_EDITED}    Get Clear DATA         ${NewUser_State_EDITED}
   ${NewUser_State_EDITED}    Set Test Variable      ${NewUser_State_EDITED}

   ${NewUser_Zipcode_EDITED}    Get Value From Json    ${file}    $.NewUser_Zipcode_EDITED
   ${NewUser_Zipcode_EDITED}    Convert To String      ${NewUser_Zipcode_EDITED}
   ${NewUser_Zipcode_EDITED}    Get Clear DATA         ${NewUser_Zipcode_EDITED}
   ${NewUser_Zipcode_EDITED}    Set Test Variable      ${NewUser_Zipcode_EDITED}

   ${NewUser_Phone_EDITED}    Get Value From Json    ${file}    $.NewUser_Phone_EDITED
   ${NewUser_Phone_EDITED}    Convert To String      ${NewUser_Phone_EDITED}
   ${NewUser_Phone_EDITED}    Get Clear DATA         ${NewUser_Phone_EDITED}
   ${NewUser_Phone_EDITED}    Set Test Variable      ${NewUser_Phone_EDITED}
      
   ${GUEST_email}    Get Value From Json    ${file}    $.GUEST_email
   ${GUEST_email}    Convert To String      ${GUEST_email}
   ${GUEST_email}    Get Clear DATA         ${GUEST_email}
   ${GUEST_email}    Set Test Variable      ${GUEST_email}
   
   ${GUEST_pwd}    Get Value From Json    ${file}    $.GUEST_pwd
   ${GUEST_pwd}    Convert To String      ${GUEST_pwd}
   ${GUEST_pwd}    Get Clear DATA         ${GUEST_pwd}
   ${GUEST_pwd}    Set Test Variable      ${GUEST_pwd}

   ${REGISTERED_email}    Get Value From Json    ${file}    $.REGISTERED_email
   ${REGISTERED_email}    Convert To String      ${REGISTERED_email}
   ${REGISTERED_email}    Get Clear DATA         ${REGISTERED_email}
   ${REGISTERED_email}    Set Test Variable      ${REGISTERED_email}

   ${REGISTERED_pwd}    Get Value From Json    ${file}    $.REGISTERED_pwd
   ${REGISTERED_pwd}    Convert To String      ${REGISTERED_pwd}
   ${REGISTERED_pwd}    Get Clear DATA         ${REGISTERED_pwd}
   ${REGISTERED_pwd}    Set Test Variable      ${REGISTERED_pwd}

   ${REGISTERED_customerZipcode}    Get Value From Json    ${file}  $.REGISTERED_customerZipcode
   ${REGISTERED_customerZipcode}    Convert To String      ${REGISTERED_customerZipcode}
   ${REGISTERED_customerZipcode}    Get Clear DATA         ${REGISTERED_customerZipcode}
   ${REGISTERED_customerZipcode}    Set Test Variable      ${REGISTERED_customerZipcode}

   ${CustomerCarePhone}    Get Value From Json    ${file}  $.CustomerCarePhone
   ${CustomerCarePhone}    Convert To String      ${CustomerCarePhone}
   ${CustomerCarePhone}    Get Clear DATA         ${CustomerCarePhone}
   ${CustomerCarePhone}    Set Test Variable      ${CustomerCarePhone}

   ${SL_store_expected_storeName}    Get Value From Json    ${file}  $.SL_store_expected_storeName
   ${SL_store_expected_storeName}    Convert To String      ${SL_store_expected_storeName}
   ${SL_store_expected_storeName}    Get Clear DATA         ${SL_store_expected_storeName}
   ${SL_store_expected_storeName}    Set Test Variable      ${SL_store_expected_storeName}

   ${SL_store_expected_address}    Get Value From Json    ${file}  $.SL_store_expected_address
   ${SL_store_expected_address}    Convert To String      ${SL_store_expected_address}
   ${SL_store_expected_address}    Get Clear DATA         ${SL_store_expected_address}
   ${SL_store_expected_address}    Set Test Variable      ${SL_store_expected_address}

   ${SL_authorized_expected_address}    Get Value From Json    ${file}  $.SL_authorized_expected_address
   ${SL_authorized_expected_address}    Convert To String      ${SL_authorized_expected_address}
   ${SL_authorized_expected_address}    Get Clear DATA         ${SL_authorized_expected_address}
   ${SL_authorized_expected_address}    Set Test Variable      ${SL_authorized_expected_address}

   ${SL_authorized_expected_city_state}    Get Value From Json    ${file}  $.SL_authorized_expected_city_state
   ${SL_authorized_expected_city_state}    Convert To String      ${SL_authorized_expected_city_state}
   ${SL_authorized_expected_city_state}    Get Clear DATA         ${SL_authorized_expected_city_state}
   ${SL_authorized_expected_city_state}    Set Test Variable      ${SL_authorized_expected_city_state}

   ${SL_authorized_expected_phone_number}    Get Value From Json    ${file}  $.SL_authorized_expected_phone_number
   ${SL_authorized_expected_phone_number}    Convert To String      ${SL_authorized_expected_phone_number}
   ${SL_authorized_expected_phone_number}    Get Clear DATA         ${SL_authorized_expected_phone_number}
   ${SL_authorized_expected_phone_number}    Set Test Variable      ${SL_authorized_expected_phone_number}
   
Get Clear DATA
    [Arguments]  ${data}
    ${clean_data}      Remove String     ${data}         [
    ${clean_data}      Remove String     ${clean_data}   ]
    ${clean_data}      Remove String     ${clean_data}   '
  RETURN  ${clean_data}


Create Key Value Pairs
    ${json_content}=    Get File    Resources/DataFiles/USData.json
    ${json}=    Evaluate    json.loads('''${json_content}''')    json
    @{key_value_pairs}=    Create List
    FOR    ${key}    IN    @{json}
        ${value}=    Get From Dictionary    ${json}    ${key}
        Append To List    ${key_value_pairs}    ${key}=${value}
    END
    RETURN    @{key_value_pairs}

Set Global Variables From Dictionary
    ${json_content}=    Get File    Resources/DataFiles/USData.json
    ${json}=    Evaluate    json.loads('''${json_content}''')    json
    @{key_value_pairs}=    Create List
    FOR    ${key}    IN    @{json}
        ${value}=    Get From Dictionary    ${json}    ${key}
        Append To List    ${key_value_pairs}    ${key}=${value}
    END
    FOR    ${key}    IN    @{key_value_pairs.keys()}
        Set Global Variable    ${key}    ${key_value_pairs}[${key}]
    END