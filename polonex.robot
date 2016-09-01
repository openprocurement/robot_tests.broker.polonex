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
${locator.status}                                               id=auction_status_name
${locator.description}                                          id=info_description
${locator.minimalStep.amount}                                   id=info_minimalStep_amount
${locator.value.amount}                                         id=info_value_amount
${locator.value.currency}                                       id=info_value_currency
${locator.value.valueAddedTaxIncluded}                          id=info_value_valueAddedTaxIncluded
${locator.tenderId}                                             id=info_auctionID
${locator.procuringEntity.name}                                 id=org_name
${locator.enquiryPeriod.startDate}                              id=enquiryPeriodDatastartDate
${locator.enquiryPeriod.endDate}                                id=enquiryPeriodDataendDate
${locator.tenderPeriod.startDate}                               id=tenderPeriodDatastartDate
${locator.tenderPeriod.endDate}                                 id=tenderPeriodDataendDate
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
  Click Element   ${sign_in}
  Sleep   2
  Clear Element Text   id=loginform-username
  Input text      ${login_email}          ${USERS.users['${ARGUMENTS[0]}'].login}
  Input text      ${login_pass}       ${USERS.users['${ARGUMENTS[0]}'].password}
  Click Button    name=login-button
  Sleep   2
  Click Element   ${prozorropage}
  Sleep   2

Створити тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tender_data


    log to console      ${ARGUMENTS[1]}

    ${title}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   title
    ${description}=                          Get From Dictionary         ${ARGUMENTS[1].data}                   description
    ${enquiryperiod_startdate}=              Get From Dictionary         ${ARGUMENTS[1].data.enquiryPeriod}     startDate
    ${enquiryperiod_enddate}=                Get From Dictionary         ${ARGUMENTS[1].data.enquiryPeriod}     endDate
    ${tenderperiod_startdate}=               Get From Dictionary         ${ARGUMENTS[1].data.tenderPeriod}      startDate
    ${tenderperiod_enddate}=                 Get From Dictionary         ${ARGUMENTS[1].data.tenderPeriod}      endDate
    ${minimalstep_amount}=                   Get From Dictionary         ${ARGUMENTS[1].data.minimalStep}       amount
    ${minimalstep_currency}=                 Get From Dictionary         ${ARGUMENTS[1].data.minimalStep}       currency
    ##${minimalstep_valueaddedtaxincluded}=  0
    ${value_amount}=                         Get From Dictionary         ${ARGUMENTS[1].data.value}             amount
    ${value_currency}=                       Get From Dictionary         ${ARGUMENTS[1].data.value}             currency
    ${value_valueaddedtaxincluded}=          Convert To String           ${ARGUMENTS[1].data.value.valueAddedTaxIncluded}
    ${value_valueaddedtaxincluded}=          convert_polonex_string      ${value_valueaddedtaxincluded}
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
    ${deliverylocation_latitude}=       Convert To String     ${deliverylocation_latitude}
    ${deliverylocation_longitude}=      Convert To String     ${deliverylocation_longitude}

    ${enquiryperiod_startdate}=     polonex_convertdate   ${enquiryperiod_startdate}
    ${enquiryperiod_enddate}=       polonex_convertdate   ${enquiryperiod_enddate}
    ${tenderperiod_startdate}=      polonex_convertdate   ${tenderperiod_startdate}
    ${tenderperiod_enddate}=        polonex_convertdate   ${tenderperiod_enddate}
    ${deliverydate_enddate}=        polonex_convertdate   ${deliverydate_enddate}


    Sleep   2
    Click Element   id=addauctionbtn

    Input text      id=addauctionform-title                                                       ${title}
    Input text      id=addauctionform-description                                                 ${description}
    Input text      id=addauctionform-enquiryperiod_startdate                                     ${enquiryperiod_startdate}
    Input text      id=addauctionform-enquiryperiod_enddate                                       ${enquiryperiod_enddate}
    Input text      id=addauctionform-tenderperiod_startdate                                      ${tenderperiod_startdate}
    Input text      id=addauctionform-tenderperiod_enddate                                        ${tenderperiod_enddate}
    Input text      id=addauctionform-minimalstep_amount                                          ${minimalstep_amount}
    Select From List    xpath=//select[@id="addauctionform-minimalstep_currency"]                 ${minimalstep_currency}
    Select From List    xpath=//select[@id="addauctionform-minimalstep_valueaddedtaxincluded"]    ${value_valueaddedtaxincluded}
    Input text      id=addauctionform-value_amount                                                ${value_amount}
    Select From List    xpath=//select[@id="addauctionform-value_currency"]                       ${value_currency}
    Select From List    xpath=//select[@id="addauctionform-value_valueaddedtaxincluded"]          ${value_valueaddedtaxincluded}
    Input text      id=additemform-0-description                                                  ${item_description}
    Select From List    xpath=//select[@id="additemform-0-classification_scheme"]                 ${classification_scheme}
    Input text      id=additemform-0-classification_description                                   ${classification_description}
    Input text      id=additemform-0-classification_id                                            ${classification_id}
    Input text      id=additemform-0-deliveryaddress_postalcode                                   ${deliveryaddress_postalcode}
    Input text      id=additemform-0-deliveryaddress_countryname                                  ${deliveryaddress_countryname}
    Input text      id=additemform-0-deliveryaddress_streetaddress                                ${deliveryaddress_streetaddress}
    Input text      id=additemform-0-deliveryaddress_region                                       ${deliveryaddress_region}
    Input text      id=additemform-0-deliveryaddress_locality                                     ${deliveryaddress_locality}
    ##Input text      id=additemform-0-deliverydate_startdate                                       ${deliverydate_startdate}
    Input text      id=additemform-0-deliverydate_enddate                                         ${deliverydate_enddate}
    Input text      id=additemform-0-unit_code                                                    ${unit_code}
    Input text      id=additemform-0-unit_name                                                    ${unit_name}
    Input text      id=additemform-0-quantity                                                     ${quantity}
    Input text      id=additemform-0-deliverylocation_latitude                                    ${deliverylocation_latitude}
    Input text      id=additemform-0-deliverylocation_longitude                                   ${deliverylocation_longitude}

    Input text      id=addauctionform-procuringentity_address_countryname                         ${procuringEntity_address_countryName}
    Input text      id=addauctionform-procuringentity_address_locality                            ${procuringEntity_address_locality}
    Input text      id=addauctionform-procuringentity_address_postalcode                          ${procuringEntity_address_postalCode}
    Input text      id=addauctionform-procuringentity_address_region                              ${procuringEntity_address_region}
    Input text      id=addauctionform-procuringentity_address_streetaddress                       ${procuringEntity_address_streetAddress}
    Input text      id=addauctionform-procuringentity_contactpoint_name                           ${procuringEntity_contactPoint_name}
    Input text      id=addauctionform-procuringentity_contactpoint_telephone                      ${procuringEntity_contactPoint_telephone}
    Input text      id=addauctionform-procuringentity_identifier_id                               ${procuringEntity_identifier_id}
    Input text      id=addauctionform-procuringentity_identifier_scheme                           ${procuringEntity_identifier_scheme}
    Input text      id=addauctionform-procuringentity_name                                        ${procuringEntity_name}

    Sleep   10

    Click Element   id=add-auction-form-save

    Sleep   2

    ${TENDER}=     Get Text        id=info_auctionID
    log to console      ${TENDER}
    [Return]    ${TENDER}

Завантажити документ
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${filepath}
  ...      ${ARGUMENTS[2]} ==  ${TENDER}

      Sleep   10
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
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}

    Go to   ${USERS.users['${ARGUMENTS[0]}'].syncpage}
    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    Sleep  2
    Click Element       name=more-search-btn
    Input Text          id=proauctionssearch-auctionid   ${ARGUMENTS[1]}
    log to console      ${ARGUMENTS[1]}
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

  polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}

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
    ##Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}

Отримати інформацію із тендера
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  fieldname
  ${return_value}=  run keyword  Отримати інформацію про ${ARGUMENTS[1]}
  [Return]  ${return_value}

Отримати тест із поля і показати на сторінці
  [Arguments]   ${fieldname}
  ${return_value}=   Get Text  ${locator.${fieldname}}
  [Return]  ${return_value}

Отримати інформацію про title
  ${return_value}=   Отримати тест із поля і показати на сторінці   title
  [Return]  ${return_value}

Отримати інформацію про status
  reload page
  ${return_value}=   Отримати тест із поля і показати на сторінці   status
  ${return_value}=   convert_polonex_string     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про description
  ${return_value}=   Отримати тест із поля і показати на сторінці   description
  [Return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=   Отримати тест із поля і показати на сторінці  value.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про minimalStep.amount
  ${return_value}=   Отримати тест із поля і показати на сторінці   minimalStep.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]   ${return_value}

Внести зміни в тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} =  username
  ...      ${ARGUMENTS[1]} =  ${TENDER_UAID}
  ##Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  polonex.Пошук тендера по ідентифікатору  ${ARGUMENTS[0]}  ${ARGUMENTS[1]}

  Click Element     id=update_auction_btn
  Sleep   2

  ${title}=   Get Text     id=addauctionform-title
  ${description}=   Get Text    id=addauctionform-description
  Click Button    id=add-auction-form-save
  Sleep   2


Отримати інформацію про items[0].quantity
  ${return_value}=   Отримати тест із поля і показати на сторінці   items[0].quantity
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].unit.code
  ${return_value}=   Отримати тест із поля і показати на сторінці   items[0].unit.code
  ${return_value}=   Convert To String     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].unit.name
  ${return_value}=   Отримати тест із поля і показати на сторінці   items[0].unit.name
  ${return_value}=   Convert To String     ${return_value}
  [Return]   ${return_value}

Отримати інформацію про value.currency
  ${return_value}=   Отримати тест із поля і показати на сторінці  value.currency
  ${return_value}=   Convert To String     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про value.valueAddedTaxIncluded
  ${return_value}=   Отримати тест із поля і показати на сторінці  value.valueAddedTaxIncluded
  ${return_value}=   convert_polonex_string      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про auctionId
  ${return_value}=   Отримати тест із поля і показати на сторінці   tenderId
  [Return]  ${return_value}

Отримати інформацію про procuringEntity.name
  ${return_value}=   Отримати тест із поля і показати на сторінці   procuringEntity.name
  [Return]  ${return_value}


Отримати інформацію про tenderPeriod.startDate
  ${return_value}=    Отримати тест із поля і показати на сторінці  tenderPeriod.startDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]    ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати тест із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${return_value}=   Отримати тест із поля і показати на сторінці  enquiryPeriod.startDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${return_value}=   Отримати тест із поля і показати на сторінці  enquiryPeriod.endDate
  ${return_value}=    convert_date_polonex      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].description
  ${return_value}=   Отримати тест із поля і показати на сторінці   items[0].description
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.id
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].classification.id
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.scheme
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].classification.scheme
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.description
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].classification.description
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.countryName
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].deliveryAddress.countryName
  [Return]      ${return_value}

Отримати інформацію про items[0].deliveryAddress.postalCode
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].deliveryAddress.postalCode
  [Return]      ${return_value}

Отримати інформацію про items[0].deliveryAddress.region
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].deliveryAddress.region
  [Return]   ${return_value}

Отримати інформацію про items[0].deliveryAddress.locality
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].deliveryAddress.locality
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.streetAddress
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].deliveryAddress.streetAddress
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryDate.endDate
  ${return_value}=   Отримати тест із поля і показати на сторінці  items[0].deliveryDate.endDate
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.latitude
  ${return_value}=   Отримати тест із поля і показати на сторінці   items[0].deliveryLocation.latitude
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.longitude
  ${return_value}=   Отримати тест із поля і показати на сторінці   items[0].deliveryLocation.longitude
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про questions[0].title
  Click Element                       xpath=//a[contains(@href, '#tab_questions')]
  ${return_value}=  Get text          ${locator.questions[0].title}
  [Return]  ${return_value}

Отримати інформацію про questions[0].description
  ${return_value}=   Отримати тест із поля і показати на сторінці   questions[0].description
  [Return]  ${return_value}

Отримати інформацію про questions[0].date
  ${return_value}=   Отримати тест із поля і показати на сторінці   questions[0].date
  ##TODO
  ##${return_value}=    convert_date_prom     ${return_value}
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
  ##Selenium2Library.Switch Browser     ${ARGUMENTS[0]}
  polonex.Пошук тендера по ідентифікатору  ${ARGUMENTS[0]}  ${ARGUMENTS[1]}

  Click Element                         xpath=//a[contains(@href, '#tab_questions')]

  Click Element                         id=add_answer_btn_0
  Input Text                            id=addanswerform-answer        ${answer}
  Click Element                         id=submit_add_answer_form

Подати цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  ${test_bid_data}
    ${amount}=    Get From Dictionary     ${ARGUMENTS[2].data.value}    amount
    ##Selenium2Library.Switch Browser       ${ARGUMENTS[0]}

    polonex.Пошук тендера по ідентифікатору  ${ARGUMENTS[0]}  ${ARGUMENTS[1]}

    Click Element       id=add_bid_btn
    Sleep   2
    Input Text          id=addbidform-sum       ${amount}
    Click Element       id=submit_add_bid_form
    Sleep   4

    ${resp}=    Get Text      id=userbidamount
    [Return]    ${resp}

Скасувати цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  none
    ...    ${ARGUMENTS[2]} ==  tenderId
    ##Selenium2Library.Switch Browser       ${ARGUMENTS[0]}

    Click Element       id=cansel-bid
    Sleep   2

Змінити цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  amount
    ...    ${ARGUMENTS[3]} ==  amount.value
    ##Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
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
    Sleep   5
    Click Element           id=add_doc_to_bid
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'prouploadform-filedata')]   ${ARGUMENTS[1]}
    sleep   2
    Click Element           id=submit_add_file_form
    sleep   2

Змінити документ в ставці
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId
    ##Selenium2Library.Switch Browser     ${ARGUMENTS[0]}
    ##polonex.Пошук тендера по ідентифікатору  ${ARGUMENTS[0]}  ${ARGUMENTS[2]}
    ##Sleep   10
    Click Element           id=file_edit_0
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'prouploadform-filedata')]   ${ARGUMENTS[1]}
    sleep   2
    Click Element           id=submit_add_file_form
    sleep   2

Отримати інформацію про bids
    [Arguments]  @{ARGUMENTS}
    ##Selenium2Library.Switch Browser       ${ARGUMENTS[0]}

Отримати посилання на аукціон для глядача
    [Arguments]  @{ARGUMENTS}
    ##Selenium2Library.Switch Browser       ${ARGUMENTS[0]}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}      ${ARGUMENTS[1]}
    Sleep   2
    ${result}=                  Get Element Attribute               id=show_public_btn@href
    [Return]   ${result}

Отримати посилання на аукціон для учасника
    [Arguments]  @{ARGUMENTS}
    ##Selenium2Library.Switch Browser       ${ARGUMENTS[0]}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    Sleep   2
    ${result}=                  Get Element Attribute               id=show_private_btn@href
    [Return]   ${result}

