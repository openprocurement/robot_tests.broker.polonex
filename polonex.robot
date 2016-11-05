*** Settings ***
Library     Selenium2Screenshots
Library     String
Library     DateTime
Library     Selenium2Library
Library     Collections
Library     polonex_helper.py


*** Variables ***
${sign_in}                                                      id=loginbtn
${login_email}                                                  id=loginform-username
${login_pass}                                                   id=loginform-password
${prozorropage}                                                 id=prozorropagebtn
${locator.title}                                                id=auction_title
${locator.dgfID}                                                id=info_dgfID
${locator.status}                                               id=auction_status_name
${locator.description}                                          id=info_description
${locator.minimalStep.amount}                      xpath=//td[contains(@id, 'info_minimalStep')]/span[contains(@class, 'amount')]
${locator.value.amount}                            xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'amount')]
${locator.value.currency}                          xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'currency')]
${locator.value.valueAddedTaxIncluded}             xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'tax')]
${locator.tenderId}                                             id=info_auctionID
${locator.procuringEntity.name}                                 id=org_name
${locator.enquiryPeriod.startDate}                              id=enquiryPeriodDatastartDate
${locator.enquiryPeriod.endDate}                                id=enquiryPeriodDataendDate
${locator.tenderPeriod.startDate}                               id=tenderPeriodDatastartDate
${locator.tenderPeriod.endDate}                                 id=tenderPeriodDataendDate

${locator.auctionPeriod.startDate}                              id=auctionPeriodDatastartDate
${locator.auctionPeriod.endDate}                                id=auctionPeriodDataendDate

${locator.proposition.value.amount}                             xpath=//div[contains(@class, 'userbidamount')]/span[contains(@id, 'userbidamount')]


${locator.items[0].quantity}                                    id=items[0]_quantity
${locator.items[0].description}                                 id=items[0]_description
${locator.items[0].unit.code}                                   id=items[0]_unit_code
${locator.items[0].unit.name}                                   id=items[0]_unit_name
${locator.items[0].deliveryAddress.postalCode}                  id=item[0]deliveryAddress_postalCode
${locator.items[0].deliveryAddress.countryName}                 id=item[0]deliveryAddress_countryName
${locator.items[0].deliveryAddress.region}                      id=item[0]deliveryAddress_region
${locator.items[0].deliveryAddress.locality}                    id=item[0]deliveryAddress_locality
${locator.items[0].deliveryAddress.streetAddress}               id=item[0]deliveryAddress_streetAddress
${locator.items[0].deliveryLocation.latitude}                   id=items[0]_deliveryLocation_latitude
${locator.items[0].deliveryLocation.longitude}                  id=items[0]_deliveryLocation_longitude
${locator.items[0].deliveryDate.endDate}                        id=item[0]deliveryDate_endDate
${locator.items[0].classification.scheme}                       id=classification_scheme
${locator.items[0].classification.id}                           id=classification_id
${locator.items[0].classification.description}                  id=classification_description
${locator.questions[0].title}                                   id=q[0]title
${locator.questions[0].description}                             id=q[0]description
${locator.questions[0].date}                                    id=q[0]date
${locator.questions[0].answer}                                  id=q[0]answer

*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]     @{ARGUMENTS}
  [Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо
  Open Browser  ${USERS.users['${ARGUMENTS[0]}'].homepage}  ${USERS.users['${ARGUMENTS[0]}'].browser}  alias=${ARGUMENTS[0]}
  Set Window Size       @{USERS.users['${ARGUMENTS[0]}'].size}
  Set Window Position   @{USERS.users['${ARGUMENTS[0]}'].position}
  Run Keyword If   '${ARGUMENTS[0]}' != 'polonex_viewer'   Login   ${ARGUMENTS[0]}

Login
  [Arguments]  @{ARGUMENTS}
  Click Element        xpath=//li[contains(@id, 'loginbtn')]/a
  Sleep   2
  Clear Element Text   id=loginform-username
  Input text      ${login_email}      ${USERS.users['${ARGUMENTS[0]}'].login}
  Input text      ${login_pass}       ${USERS.users['${ARGUMENTS[0]}'].password}
  Click Button    name=login-button
  Sleep   2
  Click Element   ${prozorropage}
  Sleep   2

Підготувати дані для оголошення тендера
  [Documentation]  Це слово використовується в майданчиків, тому потрібно, щоб воно було і тут
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  [return]  ${tender_data}

Створити тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tender_data


    ${procurementmethodtype}=                Get From Dictionary         ${ARGUMENTS[1].data}                   procurementMethodType
    ${title}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   title
    ${dgfID}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   dgfID
    ${description}=                          Get From Dictionary         ${ARGUMENTS[1].data}                   description
    ${auctionperiod_startdate}=              Get From Dictionary         ${ARGUMENTS[1].data.auctionPeriod}     startDate
    ${minimalstep_amount}=                   Get From Dictionary         ${ARGUMENTS[1].data.minimalStep}       amount
    ${minimalstep_currency}=                 Get From Dictionary         ${ARGUMENTS[1].data.minimalStep}       currency
    ##${minimalstep_valueaddedtaxincluded}=  0
    ${value_amount}=                         Get From Dictionary         ${ARGUMENTS[1].data.value}             amount
    ${value_currency}=                       Get From Dictionary         ${ARGUMENTS[1].data.value}             currency
    ${value_valueaddedtaxincluded}=          Convert To String           ${ARGUMENTS[1].data.value.valueAddedTaxIncluded}
    ${value_valueaddedtaxincluded}=          convert_polonex_string      ${value_valueaddedtaxincluded}


    ${guarantee_amount}=                     Get From Dictionary         ${ARGUMENTS[1].data.guarantee}         amount

    ${items}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   items
    ${item0}=                                Get From List               ${items}                               0
    ${item_description}=                     Get From Dictionary         ${item0}                               description
    ${classification_scheme}=                Get From Dictionary         ${item0.classification}                scheme
    ${classification_description}=           Get From Dictionary         ${item0.classification}                description
    ${classification_id}=                    Get From Dictionary         ${item0.classification}                id
    ${deliveryaddress_postalcode}=           Get From Dictionary         ${item0.deliveryAddress}               postalCode
    ${deliveryaddress_countryname}=          Get From Dictionary         ${item0.deliveryAddress}               countryName
    ${deliveryaddress_streetaddress}=        Get From Dictionary         ${item0.deliveryAddress}               streetAddress
    ${deliveryaddress_region}=               Get From Dictionary         ${item0.deliveryAddress}               region
    ${deliveryaddress_locality}=             Get From Dictionary         ${item0.deliveryAddress}               locality
    ##${deliverydate_startdate}=             Get From Dictionary         ${item0.deliveryDate}                title
    ${deliverydate_enddate}=                 Get From Dictionary         ${item0.deliveryDate}                  endDate
    ${unit_code}=                            Get From Dictionary         ${item0.unit}                          code
    ${unit_name}=                            Get From Dictionary         ${item0.unit}                          name
    ${quantity}=                             Get From Dictionary         ${item0}                               quantity
    ${deliverylocation_latitude}=            Get From Dictionary         ${item0.deliveryLocation}              latitude
    ${deliverylocation_longitude}=           Get From Dictionary         ${item0.deliveryLocation}              longitude


    ${procuringEntity}=                      Get From Dictionary         ${ARGUMENTS[1].data}                   procuringEntity

    ${procuringEntity_address_countryName}=      Get From Dictionary     ${procuringEntity.address}            countryName
    ${procuringEntity_address_locality}=         Get From Dictionary     ${procuringEntity.address}            locality
    ${procuringEntity_address_postalCode}=       Get From Dictionary     ${procuringEntity.address}            postalCode
    ${procuringEntity_address_region}=           Get From Dictionary     ${procuringEntity.address}            region
    ${procuringEntity_address_streetAddress}=    Get From Dictionary     ${procuringEntity.address}            streetAddress
    ${procuringEntity_contactPoint_name}=        Get From Dictionary     ${procuringEntity.contactPoint}       name
    ${procuringEntity_contactPoint_telephone}=   Get From Dictionary     ${procuringEntity.contactPoint}       telephone
    ${procuringEntity_identifier_id}=            Get From Dictionary     ${procuringEntity.identifier}         id
    ${procuringEntity_identifier_scheme}=        Get From Dictionary     ${procuringEntity.identifier}         scheme
    ${procuringEntity_name}=                     Get From Dictionary     ${procuringEntity}                    name

    ${minimalstep_amount}=              Convert To String     ${minimalstep_amount}
    ${value_amount}=                    Convert To String     ${value_amount}
    ${guarantee_amount}=                Convert To String     ${guarantee_amount}
    ${deliverylocation_latitude}=       Convert To String     ${deliverylocation_latitude}
    ${deliverylocation_longitude}=      Convert To String     ${deliverylocation_longitude}

    ${auctionperiod_startdate}=        polonex_convertdate   ${auctionperiod_startdate}

    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    Sleep   2
    Click Element       xpath=//a[contains(@id, 'addauctionbtn')]
    Sleep   4


    Select From List    xpath=//select[@id="addauctionform-procurementmethodtype"]                ${procurementmethodtype}
    Select From List    xpath=//select[@id="addauctionform-minimalstep_valueaddedtaxincluded"]    ${value_valueaddedtaxincluded}
    Select From List    xpath=//select[@id="addauctionform-value_valueaddedtaxincluded"]          ${value_valueaddedtaxincluded}
    Select From List    xpath=//select[@id="addauctionform-procuringentity_identifier_scheme"]    ${procuringEntity_identifier_scheme}
    Select From List    xpath=//select[@id="additemform-0-unit_code"]                             ${unit_code}
    Input text      id=addauctionform-title                                                       ${title}
    Input text      id=addauctionform-dgfid                                                       ${dgfID}


    Input text      id=addauctionform-description                                                 ${description}
    Input text      id=addauctionform-auctionperiod_startdate                                     ${auctionperiod_startdate}
    Input text      id=addauctionform-minimalstep_amount                                          ${minimalstep_amount}
    Input text      id=addauctionform-value_amount                                                ${value_amount}

    Input text      id=addauctionform-guarantee_amount                                            ${guarantee_amount}

    Input text      id=additemform-0-description                                                  ${item_description}
    Input text      id=additemform-0-quantity                                                     ${quantity}

    Input text      id=addauctionform-procuringentity_address_countryname                         ${procuringEntity_address_countryName}
    Input text      id=addauctionform-procuringentity_address_locality                            ${procuringEntity_address_locality}
    Input text      id=addauctionform-procuringentity_address_postalcode                          ${procuringEntity_address_postalCode}
    Input text      id=addauctionform-procuringentity_address_region                              ${procuringEntity_address_region}
    Input text      id=addauctionform-procuringentity_address_streetaddress                       ${procuringEntity_address_streetAddress}
    Input text      id=addauctionform-procuringentity_contactpoint_name                           ${procuringEntity_contactPoint_name}
    Input text      id=addauctionform-procuringentity_contactpoint_telephone                      ${procuringEntity_contactPoint_telephone}
    Input text      id=addauctionform-procuringentity_identifier_id                               ${procuringEntity_identifier_id}
    Input text      id=addauctionform-procuringentity_name                                        ${procuringEntity_name}

    ##Select From List    xpath=//select[@id="additemform-0-classification_id"]                     ${classification_id}

    Execute Javascript    $('#additemform-0-classification_id').val('${classification_id}');
    Execute Javascript    $('#additemform-0-classification_id').trigger('change');

    Sleep   15
    Click Element   xpath=//button[contains(@id, 'add-auction-form-save')]
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_auctionID')]   30

    ${tender_uaid}=     Get Text        xpath=//td[contains(@id, 'info_auctionID')]
    [Return]    ${tender_uaid}

Завантажити документ
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${filepath}
  ...      ${ARGUMENTS[2]} ==  ${tender_uaid}

      Click Element     id=add_doc_to_auction_btn
      Sleep   2
      Choose File       id=auctionfile   ${ARGUMENTS[1]}
      Sleep   2
      Click Button      id=submit_add_auction_file_form
      Sleep   1
      Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
      Sleep   2


Пошук тендера по ідентифікатору
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${tender_uaid}

    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    Sleep  2
    Click Element       name=more-search-btn
    Sleep  2
    Input Text          id=proauctionssearch-auctionid   ${ARGUMENTS[1]}
    Sleep  2
    Click Element       name=search-btn
    Sleep  2
    Click Element     xpath=(//a[contains(@class, 'btn-default')])[1]
    Sleep  1

Задати питання
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tenderUaId
  ...      ${ARGUMENTS[2]} ==  questionId
  ${title}=        Get From Dictionary  ${ARGUMENTS[2].data}  title
  ${description}=  Get From Dictionary  ${ARGUMENTS[2].data}  description

  Click Element         id=add_question_btn
  Sleep  2
  Input Text          id=addquestionform-title          ${title}
  Input Text          id=addquestionform-description    ${description}
  Sleep  2
  Click Element       id=submit_add_question_form
  Sleep  2

Оновити сторінку з тендером
    [Arguments]    @{ARGUMENTS}
    [Documentation]    ${ARGUMENTS[0]} = username
    ...      ${ARGUMENTS[1]} = ${TENDER_UAID}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}

Отримати інформацію із тендера
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  ${username}
  ...      ${ARGUMENTS[1]} ==  ${tender_uaid}
  ...      ${ARGUMENTS[2]} ==  ${field_name}
  ${return_value}=  run keyword  Отримати інформацію про ${ARGUMENTS[2]}
  [Return]  ${return_value}

Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  ${field_name}=  Отримати шлях до поля об’єкта  ${username}  ${field_name}  ${item_id}
  Run Keyword And Return  polonex.Отримати інформацію із тендера  ${username}  ${tender_uaid}  ${field_name}

Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  ${return_value}=   Get Text  ${locator.${fieldname}}
  [Return]  ${return_value}

Отримати інформацію про title
  ${return_value}=   Отримати текст із поля і показати на сторінці   title
  [Return]  ${return_value}

Отримати інформацію про dgfID
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfID
  [Return]  ${return_value}

Отримати інформацію про status
  reload page
  ${return_value}=   Отримати текст із поля і показати на сторінці   status
  ${return_value}=   convert_polonex_string     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про description
  ${return_value}=   Отримати текст із поля і показати на сторінці   description
  [Return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про minimalStep.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]   ${return_value}

Внести зміни в тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} =  username
  ...      ${ARGUMENTS[1]} =  ${TENDER_UAID}

  Click Element     id=update_auction_btn
  Sleep   2

  ${title}=   Get Text     id=addauctionform-title
  ${description}=   Get Text    id=addauctionform-description
  Click Button    id=add-auction-form-save
  Sleep   2


Отримати інформацію про items[0].quantity
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].quantity
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].unit.code
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].unit.code
  ${return_value}=   Convert To String     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].unit.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].unit.name
  ${return_value}=   Convert To String     ${return_value}
  [Return]   ${return_value}

Отримати інформацію про value.currency
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.currency
  ${return_value}=   Convert To String     ${return_value}
  ${return_value}=   convert_polonex_string      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про value.valueAddedTaxIncluded
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.valueAddedTaxIncluded
  ${return_value}=   convert_polonex_string      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про auctionId
  ${return_value}=   Отримати текст із поля і показати на сторінці   tenderId
  [Return]  ${return_value}

Отримати інформацію про procuringEntity.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   procuringEntity.name
  [Return]  ${return_value}


Отримати інформацію про tenderPeriod.startDate
  ${return_value}=    Отримати текст із поля і показати на сторінці  tenderPeriod.startDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]    ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.endDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про auctionPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.startDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про auctionPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.endDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].description
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.id
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.id
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.scheme
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.scheme
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.description
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.description
  ${return_value}=   Convert To String     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.countryName
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.countryName
  [Return]      ${return_value}

Отримати інформацію про items[0].deliveryAddress.postalCode
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.postalCode
  [Return]      ${return_value}

Отримати інформацію про items[0].deliveryAddress.region
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.region
  [Return]   ${return_value}

Отримати інформацію про items[0].deliveryAddress.locality
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.locality
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.streetAddress
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.streetAddress
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryDate.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryDate.endDate
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.latitude
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].deliveryLocation.latitude
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.longitude
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].deliveryLocation.longitude
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про questions[0].title
  Click Element                       xpath=//a[contains(@href, '#tab_questions')]
  ${return_value}=  Get text          ${locator.questions[0].title}
  [Return]  ${return_value}

Отримати інформацію про questions[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].description
  [Return]  ${return_value}

Отримати інформацію про questions[0].date
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].date
  [Return]  ${return_value}

Отримати інформацію про questions[0].answer
  Click Element                       xpath=//a[contains(@href, '#tab_questions')]
  ${return_value}=  Get text          ${locator.questions[0].answer}
  [Return]  ${return_value}

Відповісти на питання
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} = 0
  ...      ${ARGUMENTS[3]} = answer_data
  ${answer}=     Get From Dictionary  ${ARGUMENTS[3].data}  answer
  Reload Page
  Click Element                         xpath=//a[contains(@href, '#tab_questions')]
  Sleep     4
  Click Element                         xpath=//a[contains(@id, 'add_answer_btn_0')]
  Sleep     4
  Input Text                            id=addanswerform-answer        ${answer}
  Click Element                         id=submit_add_answer_form

Подати цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  ${test_bid_data}
    ${amount}=    Get From Dictionary     ${ARGUMENTS[2].data.value}    amount
    ${amount}=              Convert To String     ${amount}

    Click Element       id=add_bid_btn
    Sleep   2
    Input Text          id=addbidform-sum       ${amount}
    Sleep   4
    Click Element       id=submit_add_bid_form
    Wait Until Element Is Visible       id=userbidamount   30

    ${resp}=    Get Text      id=userbidamount
    [Return]    ${resp}

Скасувати цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  none
    ...    ${ARGUMENTS[2]} ==  tenderId

    Click Element       id=cansel-bid
    Sleep   2

Змінити цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  amount
    ...    ${ARGUMENTS[3]} ==  amount.value

    Click Element       id=cansel-bid
    Sleep   2
    Click Element       id=add_bid_btn
    Sleep   2
    Input Text          id=addbidform-sum       ${ARGUMENTS[3]}
    Click Element       id=submit_add_bid_form
    Sleep   4

    ${resp}=    Get Text      id=userbidamount
    [Return]    ${resp}

Завантажити документ в ставку
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId
    Click Element           id=edit_user_bid
    Sleep   2
    Click Element           id=bid_doc_upload_fieldcommercialProposal
    ##Choose File             xpath=//input[contains(@id, 'bid_doc_upload_fieldcommercialProposal')]   ${ARGUMENTS[1]}
    sleep   4
    Click Element           id=submit_add_bid_form
    sleep   2

Змінити документ в ставці
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId

    Click Element           id=file_edit_0
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'prouploadform-filedata')]   ${ARGUMENTS[1]}
    sleep   2
    Click Element           id=submit_add_file_form
    sleep   2

Отримати пропозицію
  [Arguments]  ${field}
  Wait Until Page Contains Element    ${locator.proposition.${field}}            60
  ${proposition_amount}=            Get Value                                    ${locator.proposition.${field}}
  log                                 ${proposition_amount}
  ${proposition_amount}=              Convert To Number                          ${proposition_amount}
  log                                 ${proposition_amount}
  Capture Page Screenshot
  ${data}=     Create Dictionary
  ${bid}=      Create Dictionary
  ${value}=    Create Dictionary
  Set To Dictionary  ${bid}     data=${data}
  Set To Dictionary  ${data}    value=${value}
  Set To Dictionary  ${value}   amount=${proposition_amount}
  [return]           ${bid}

Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  ${bid}=   polonex.Отримати пропозицію  ${field}
  [return]  ${bid.data.${field}}

Отримати інформацію про bids
    [Arguments]  @{ARGUMENTS}
    ##Selenium2Library.Switch Browser       ${ARGUMENTS[0]}

Отримати посилання на аукціон для глядача
    [Arguments]  @{ARGUMENTS}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    ${result}=                  Get Element Attribute               id=show_public_btn@href
    [Return]   ${result}
Отримати посилання на аукціон для учасника
    [Arguments]  @{ARGUMENTS}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    ${result}=                  Get Element Attribute               id=show_private_btn@href
    [Return]   ${result}

Підтвердити постачальника
  [Documentation]
  ...      [Arguments] Username, tender uaid and number of the award to confirm
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  sleep  5
  Capture Page Screenshot
  ##Click Element  xpath=//a[@data-target='#modalGetAwards']

Підтвердити підписання контракту
  [Documentation]
  ...      [Arguments] Username, tender uaid, contract number
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  sleep  10
  Capture Page Screenshot
  ##Click Element  xpath=//a[text()='Контракт']
