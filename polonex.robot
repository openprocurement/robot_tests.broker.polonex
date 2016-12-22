*** Settings ***
Library     Selenium2Screenshots
Library     String
Library     DateTime
Library     Selenium2Library
Library     Collections
Library     polonex_helper.py


*** Variables ***
${sign_in}                                           id=loginbtn
${login_email}                                       id=loginform-username
${login_pass}                                        id=loginform-password
${prozorropage}                                      id=prozorropagebtn
${locator.title}                                     id=auction_title
${locator.dgfID}                                     id=info_dgfID
${locator.dgfDecisionDate}                           id=info_dgfDecisionDate
${locator.dgfDecisionID}                             id=info_dgfDecisionID
${locator.tenderAttempts}                            id=info_tenderAttempts
${locator.procurementMethodType}                     id=info_procurementMethodType
${locator.eligibilityCriteria}                       id=eligibilityCriteria_marker
${locator.status}                                    id=auction_status_name
${locator.description}                               id=info_description
${locator.minimalStep.amount}                        xpath=//td[contains(@id, 'info_minimalStep')]/span[contains(@class, 'amount')]
${locator.value.amount}                              xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'amount')]
${locator.value.currency}                            xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'currency')]
${locator.value.valueAddedTaxIncluded}               xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'tax')]
${locator.tenderId}                                  id=info_auctionID
${locator.procuringEntity.name}                      id=org_name
${locator.enquiryPeriod.startDate}                   id=enquiryPeriodDatastartDate
${locator.enquiryPeriod.endDate}                     id=enquiryPeriodDataendDate
${locator.tenderPeriod.startDate}                    id=tenderPeriodDatastartDate
${locator.tenderPeriod.endDate}                      id=tenderPeriodDataendDate

${locator.auctionPeriod.startDate}                   id=auctionPeriodDatastartDate
${locator.auctionPeriod.endDate}                     id=auctionPeriodDataendDate

${locator.proposition.value.amount}                  xpath=//div[contains(@class, 'userbidinfo')]/span[contains(@id, 'userbidamount')]


${locator.items[0].quantity}                         id=items[0]_quantity
${locator.items[0].description}                      id=items[0]_description
${locator.items[1].description}                      id=items[1]_description
${locator.items[2].description}                      id=items[2]_description
${locator.items[3].description}                      id=items[3]_description
${locator.items[0].unit.code}                        id=items[0]_unit_code
${locator.items[0].unit.name}                        id=items[0]_unit_name
${locator.items[0].deliveryAddress.postalCode}       id=item[0]deliveryAddress_postalCode
${locator.items[0].deliveryAddress.countryName}      id=item[0]deliveryAddress_countryName
${locator.items[0].deliveryAddress.region}           id=item[0]deliveryAddress_region
${locator.items[0].deliveryAddress.locality}         id=item[0]deliveryAddress_locality
${locator.items[0].deliveryAddress.streetAddress}    id=item[0]deliveryAddress_streetAddress
${locator.items[0].deliveryLocation.latitude}        id=items[0]_deliveryLocation_latitude
${locator.items[0].deliveryLocation.longitude}       id=items[0]_deliveryLocation_longitude
${locator.items[0].deliveryDate.endDate}             id=item[0]deliveryDate_endDate
${locator.items[0].classification.scheme}            id=classification_scheme
${locator.items[0].classification.id}                id=classification_id
${locator.items[0].classification.description}       id=classification_description
${locator.questions[0].title}                        id=q[0]title
${locator.questions[0].description}                  id=q[0]description
${locator.questions[0].date}                         id=q[0]date
${locator.questions[0].answer}                       id=q[0]answer

${locator.cancellations[0].status}                   id=cancell_status
${locator.cancellations[0].reason}                   id=cancell_reason

${locator.cancelldoc.title}                          xpath=//div[contains(@class, 'fg_modal_title')]
${locator.cancelldoc.description}                    xpath=//div[contains(@class, 'fg_modal_description')]

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
    ${dgfDecisionDate}=                      Get From Dictionary         ${ARGUMENTS[1].data}                   dgfDecisionDate
    ${dgfDecisionID}=                        Get From Dictionary         ${ARGUMENTS[1].data}                   dgfDecisionID
    ${tenderAttempts}=                       Get From Dictionary         ${ARGUMENTS[1].data}                   tenderAttempts
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
    ${tenderAttempts}=                  Convert To String     ${tenderAttempts}

    ${auctionperiod_startdate}=        polonex_convertdate   ${auctionperiod_startdate}
    ${dgfDecisionDate}=                polonex_convertdate   ${dgfDecisionDate}

    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    Sleep   2
    Click Element       xpath=//a[contains(@id, 'addauctionbtn')]
    Sleep   4


    Select From List    xpath=//select[@id="addauctionform-procurementmethodtype"]                ${procurementmethodtype}
    Select From List    xpath=//select[@id="addauctionform-tenderattempts"]                       ${tenderAttempts}
    Select From List    xpath=//select[@id="addauctionform-minimalstep_valueaddedtaxincluded"]    ${value_valueaddedtaxincluded}
    Select From List    xpath=//select[@id="addauctionform-value_valueaddedtaxincluded"]          ${value_valueaddedtaxincluded}
    Select From List    xpath=//select[@id="addauctionform-procuringentity_identifier_scheme"]    ${procuringEntity_identifier_scheme}
    Input text      id=addauctionform-title                                                       ${title}
    Input text      id=addauctionform-dgfid                                                       ${dgfID}

    Input text      id=addauctionform-dgfdecisionid                                               ${dgfDecisionID}
    Input text      id=addauctionform-dgfdecisiondate                                             ${dgfDecisionDate}

    Input text      id=addauctionform-description                                                 ${description}
    Input text      id=addauctionform-auctionperiod_startdate                                     ${auctionperiod_startdate}
    Input text      id=addauctionform-minimalstep_amount                                          ${minimalstep_amount}
    Input text      id=addauctionform-value_amount                                                ${value_amount}

    Input text      id=addauctionform-guarantee_amount                                            ${guarantee_amount}


    Input text      id=addauctionform-procuringentity_address_countryname                         ${procuringEntity_address_countryName}
    Input text      id=addauctionform-procuringentity_address_locality                            ${procuringEntity_address_locality}
    Input text      id=addauctionform-procuringentity_address_postalcode                          ${procuringEntity_address_postalCode}
    Input text      id=addauctionform-procuringentity_address_region                              ${procuringEntity_address_region}
    Input text      id=addauctionform-procuringentity_address_streetaddress                       ${procuringEntity_address_streetAddress}
    Input text      id=addauctionform-procuringentity_contactpoint_name                           ${procuringEntity_contactPoint_name}
    Input text      id=addauctionform-procuringentity_contactpoint_telephone                      ${procuringEntity_contactPoint_telephone}
    Input text      id=addauctionform-procuringentity_identifier_id                               ${procuringEntity_identifier_id}
    Input text      id=addauctionform-procuringentity_name                                        ${procuringEntity_name}

    polonex.Додати предмети      ${items}

    Sleep   5
    Click Element   xpath=//button[contains(@id, 'add-auction-form-save')]
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_auctionID')]   30

    ${tender_uaid}=     Get Text        xpath=//td[contains(@id, 'info_auctionID')]
    [Return]    ${tender_uaid}

Додати предмети
    [Arguments]  ${items}
    ${Items_length}=   Get Length   ${items}
    :FOR   ${index}   IN RANGE   ${Items_length}
    \   polonex.Додати предмет   ${items[${index}]}     ${index}

Додати предмет
    [Arguments]  ${item}  ${index}
    ${index}=  Convert To Integer  ${index}
    Run Keyword If  ${index} != 0   Click Element   id=additem
    Run Keyword If  ${index} != 0   Sleep           4
    Select From List    xpath=//select[@id="additemform-${index}-unit_code"]         ${item.unit.code}
    Input text      id=additemform-${index}-description                              ${item.description}
    Input text      id=additemform-${index}-quantity                                 ${item.quantity}
    Execute Javascript    $("#additemform-${index}-classification_id").val("${item.classification.id}");
    Execute Javascript    $("#additemform-${index}-classification_id").trigger("change");

Додати предмет закупівлі
    [Arguments]  ${username}  ${tender_uaid}  ${item}
    ##polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element   xpath=//a[contains(@id, "update_auction_btn")]
    polonex.Додати предмет      ${item}    11

Видалити предмет закупівлі
    [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
    ##polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element   xpath=//a[contains(@id, "update_auction_btn")]
    Click Element   xpath=//a[contains(@class, "close_lot_item")]

Завантажити документ
    [Arguments]  ${username}  ${filepath}  ${tender_uaid}
    ##polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    ##Click Element   xpath=//a[contains(@id, "update_auction_btn")]
    ##Sleep   4
    Choose File     xpath=//input[contains(@id, "doc_upload_field_biddingDocuments")]   ${filepath}
    Sleep   15
    ##Sleep   5
    ##Click Button    id=add-auction-form-save

Завантажити ілюстрацію
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    ##polonex.пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    ##Wait Until Element Is Visible       xpath=//a[contains(@id, "update_auction_btn")]      30
    ##Click Element   xpath=//a[contains(@id, "update_auction_btn")]
    ##Sleep   4
    Choose File       id=doc_upload_field_illustration        ${filepath}
    Sleep   15
    ##sleep  5
    ##Click Button    id=add-auction-form-save

Додати Virtual Data Room
    [Arguments]  ${username}  ${tender_uaid}  ${vdr_url}  ${title}=Sample Virtual Data Room
    ##polonex.пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    ##Click Element     xpath=//a[contains(@id, "update_auction_btn")]
    log to console      ${vdr_url}
    Wait Until Element Is Visible       xpath=//div[contains(@id,'doc_upload_wrap_virtualDataRoom')]/div/div[contains(@class,'ho_upload_link_btn')]      30
    Click Element   xpath=//div[contains(@id,'doc_upload_wrap_virtualDataRoom')]/div/div[contains(@class,'ho_upload_link_btn')]
    Sleep   4
    Input Text      jquery=#doc_upload_wrap_virtualDataRoom input#input_link   ${vdr_url}
    Click Element    jquery=#doc_upload_wrap_virtualDataRoom a.linkadd_submit
    Sleep   4
    ##Click Button    id=add-auction-form-save

Додати публічний паспорт активу
    [Arguments]  ${username}  ${tender_uaid}  ${certificate_url}
    ##polonex.пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    ##Click Element     xpath=//a[contains(@id, "update_auction_btn")]
    Wait Until Element Is Visible       xpath=//div[contains(@id,'doc_upload_wrap_x_dgfPublicAssetCertificate')]/div/div[contains(@class,'ho_upload_link_btn')]      30
    Click Element   xpath=//div[contains(@id,'doc_upload_wrap_x_dgfPublicAssetCertificate')]/div/div[contains(@class,'ho_upload_link_btn')]
    Sleep   4
    Input Text      jquery=#doc_upload_wrap_x_dgfPublicAssetCertificate input#input_link   ${certificate_url}
    Click Element    jquery=#doc_upload_wrap_x_dgfPublicAssetCertificate a.linkadd_submit
    Sleep   4
    ##Click Button    id=add-auction-form-save

Завантажити документ в тендер з типом
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${documentType}
    ##polonex.пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    ##Wait Until Element Is Visible       xpath=//a[contains(@id, "update_auction_btn")]      30
    ##Click Element   xpath=//a[contains(@id, "update_auction_btn")]
    Sleep   4
    Choose File       id=doc_upload_field_${documentType}        ${filepath}
    sleep  10
    ##Click Button    id=add-auction-form-save

Додати офлайн документ
    [Arguments]  ${username}  ${tender_uaid}  ${accessDetails}
    log to console      ${accessDetails}
    Click Button    id=add-auction-form-save

Завантажити протокол аукціону
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
    polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element           id=add_user_bid_docs
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'bid_doc_upload_fieldauctionProtocol')]   ${filepath}
    Click Button           xpath=//button[contains(@id,'submit_add_bid_doc_form')]

Пошук тендера по ідентифікатору
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${tender_uaid}
    Switch browser   ${ARGUMENTS[0]}
    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    Sleep  2
    Click Element       name=more-search-btn
    Sleep  2
    Input Text          id=proauctionssearch-auctionid   ${ARGUMENTS[1]}
    Sleep  2
    Click Element       name=search-btn
    Sleep  5
    Click Element     xpath=(//a[contains(@class, 'auction_detail_btn')])
    Wait Until Element Is Visible       id=info   30
    Capture Page Screenshot

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

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  polonex.Задати питання  ${username}  ${tender_uaid}  ${question}

Задати запитання на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${question}
  polonex.Задати питання  ${username}  ${tender_uaid}  ${question}

Оновити сторінку з тендером
    [Arguments]    @{ARGUMENTS}
    [Documentation]    ${ARGUMENTS[0]} = username
    ...      ${ARGUMENTS[1]} = ${TENDER_UAID}
    Switch browser   ${ARGUMENTS[0]}
    Go to   ${USERS.users['${ARGUMENTS[0]}'].syncpage}
    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}

Отримати інформацію із тендера
    [Arguments]  ${username}  ${tender_uaid}  ${field_name}
    ${return_value}=  Run Keyword If
    ...  'classification' in '${field_name}'       Отримати інформацію про класифікатор із предмету  ${field_name}
    ...  ELSE IF    'unit' in '${field_name}'      Отримати інформацію про юніт із предмету  ${field_name}
    ...  ELSE IF    'items' in '${field_name}'     Отримати інформацію із предмету без індекса  ${field_name}
    ...  ELSE IF    'questions' in '${field_name}'     Отримати інформацію із запитання без індекса  ${field_name}
    ...  ELSE       Отримати інформацію про ${field_name}
    [Return]  ${return_value}

Отримати інформацію із предмету без індекса
    [Arguments]  ${field_name}
    ${prop_fild_name}=         Replace String    ${field_name}    .   _    count=1
    ${return_value}=   Get Text     id=${prop_fild_name}
    ${return_value}=  Run Keyword If
    ...  'quantity' in '${prop_fild_name}'    Convert To Integer    ${return_value}
    ...  ELSE       Convert To String   ${return_value}
    [Return]  ${return_value}

Отримати інформацію із запитання без індекса
    [Arguments]  ${field_name}
    ${index}=   Get Substring   ${field_name}    10      11
    ${index}=   Convert To Integer    ${index}
    ${list}=    Split String    ${field_name}    .
    ${return_value}=   Get Text     id=q[${index}]${list[1]}
    [Return]  ${return_value}

Отримати інформацію про класифікатор із предмету
    [Arguments]  ${field_name}
    ${prop_fild_name}=         Replace String    ${field_name}    .   _    count=2
    ${return_value}=   Get Text     id=${prop_fild_name}
    [Return]  ${return_value}

Отримати інформацію із документа по індексу
    [Arguments]  ${username}  ${tender_uaid}  ${document_index}  ${field}
    log to console      ${document_index}
    log to console      ${field}

Отримати інформацію про юніт із предмету
    [Arguments]  ${field_name}
    ${prop_fild_name}=         Replace String    ${field_name}    .   _    count=2
    ${return_value}=   Get Text     id=${prop_fild_name}
    [Return]  ${return_value}

Отримати інформацію із предмету
    [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
    ${index}=   Get Element Attribute   xpath=//td[contains(text(), '${item_id}')]@id
    ${index}=   Get Substring   ${index}    0   9
    ${return_value}=    Get Text     id=${item_id}${field_name}
    ${return_value}=  Run Keyword If
    ...  ${field_name} == 'quantity'      Convert To Integer    ${return_value}
    [Return]  ${return_value}

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

Отримати інформацію про dgfDecisionDate
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfDecisionDate
  [Return]  ${return_value}

Отримати інформацію про dgfDecisionID
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfDecisionID
  [Return]  ${return_value}

Отримати інформацію про tenderAttempts
    ${return_value}=   Отримати текст із поля і показати на сторінці   tenderAttempts
    ${return_value}=   convert_polonex_string     ${return_value}
    [Return]  ${return_value}

Отримати інформацію про eligibilityCriteria
  ${return_value}=   Отримати текст із поля і показати на сторінці   eligibilityCriteria
  [Return]  ${return_value}

Отримати інформацію про status
  reload page
  ${return_value}=   Отримати текст із поля і показати на сторінці   status
  ${return_value}=   convert_polonex_string     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про description
  ${return_value}=   Отримати текст із поля і показати на сторінці   description
  [Return]  ${return_value}

Отримати інформацію про procurementMethodType
  ${return_value}=   Отримати текст із поля і показати на сторінці   procurementMethodType
  ${return_value}=   convert_polonex_string     ${return_value}
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
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}  ${field_value}
  polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Click Element     id=update_auction_btn
  Sleep   2
  Input text  name=addauctionform-[${field_name}]  ${field_value}
  Click Button    id=add-auction-form-save
  Wait Until Page Contains  ${field_value}  30

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
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]    ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.endDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]  ${return_value}

Отримати інформацію про auctionPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.startDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [return]  ${return_value}

Отримати інформацію про auctionPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.endDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]  ${return_value}

Отримати інформацію про items[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].description
  [Return]  ${return_value}

Отримати інформацію про items[1].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[1].description
  [Return]  ${return_value}

Отримати інформацію про items[2].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[2].description
  [Return]  ${return_value}

Отримати інформацію про items[3].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[3].description
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
  ${return_value}=  Get text          ${locator.questions[0].title}
  [Return]  ${return_value}

Отримати інформацію про questions[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].description
  [Return]  ${return_value}

Отримати інформацію про questions[0].date
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].date
  [Return]  ${return_value}

Отримати інформацію про questions[0].answer
  ${return_value}=  Get text          ${locator.questions[0].answer}
  [Return]  ${return_value}

Отримати інформацію про cancellations[0].status
  ${return_value}=  Get text          ${locator.cancellations[0].status}
  [Return]  ${return_value}

Отримати інформацію про cancellations[0].reason
  ${return_value}=  Get text          ${locator.cancellations[0].reason}
  [Return]  ${return_value}

Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  ${tender}=  polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${return_value}=   Get Element Attribute   xpath=//div[contains(@data-name,'${doc_id}')]@data-name
  [Return]  ${return_value}

Отримати документ
    [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
    ${file_name}=   Get Element Attribute   xpath=//div[contains(@data-name,'${doc_id}')]@data-name
    ${url}=   Get Element Attribute   xpath=//div[contains(@data-name,'${doc_id}')]@data-src
    polonex_download_file   ${url}  ${file_name}  ${OUTPUT_DIR}
    [return]  ${file_name}

Отримати кількість документів в тендері
    [Arguments]  ${username}  ${tender_uaid}
    ${number}=   Get Element Attribute   xpath=//p[contains(@id,'document_section_title')]@data-num
    ${number}=   Convert To Number      ${number}
    [return]  ${number}

Отримати кількість документів в ставці
    [Arguments]  ${username}  ${tender_uaid}  ${bid_index}
    ${bid_doc_number}=   Get Text      id=bid_doc_count
    ${bid_doc_number}=   Convert To Number      ${bid_doc_number}
    [return]  ${bid_doc_number}

Отримати кількість предметів в тендері
    [Arguments]  ${username}  ${tender_uaid}
    polonex.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
    ${res}=   Get Text      id=item_count
    ##${res}=   Convert To Number      ${res}
    [return]  ${res}

Отримати дані із документу пропозиції
    [Arguments]  ${username}  ${tender_uaid}  ${bid_index}  ${document_index}  ${field}
    ${doc_value}=   Get Element Attribute   xpath=//p[contains(@id,"bid_files_auctionProtocol")]@data-key
    [return]  ${doc_value}

Скасування рішення кваліфікаційної комісії
    [Arguments]  ${username}  ${tender_uaid}  ${award_num}
    Click Element                         xpath=//a[contains(@id, "cansel_winer_btn")]
    Wait Until Page Contains   Рішення кваліфікаційної комісії скасовано   30

Дискваліфікувати постачальника
    [Arguments]  ${username}  ${tender_uaid}  ${award_num}  ${description}
    polonex.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
    Capture Page Screenshot

Завантажити документ рішення кваліфікаційної комісії
    [Arguments]  ${username}  ${document}  ${tender_uaid}  ${award_num}
    polonex.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
    Capture Page Screenshot

Відповісти на запитання
    [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
    ##polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    ##log to console      ${question_id}
    ${index}=   Get Element Attribute   xpath=//div[contains(text(), '${question_id}')]@id
    ${index}=   Get Substring   ${index}    2   3
    Click Element                         xpath=//a[contains(@id, 'add_answer_btn_${index}')]
    Sleep     4
    Input Text                            id=addanswerform-answer        ${answer_data.data.answer}
    Sleep     2
    Click Element                         id=submit_add_answer_form

Подати цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  ${test_bid_data}
    ##${status}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${ARGUMENTS[2].data}  qualified
    ${status}=          Get From Dictionary         ${ARGUMENTS[2].data}    qualified
    log to console      ${status}
    ${amount}=    Get From Dictionary     ${ARGUMENTS[2].data.value}    amount
    ${amount}=          Convert To String     ${amount}
    Run Keyword If  ${status}
    ...  polonex.Пошук тендера по ідентифікатору  ${ARGUMENTS[0]}  ${ARGUMENTS[1]}
    ...  ELSE   Go To  http://test.polonex.in.ua
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
    Click Element       id=edit_user_bid
    Sleep   2
    ${newsum}=          Convert To String       ${ARGUMENTS[3]}
    Input Text          id=addbidform-sum       ${newsum}
    Click Element       id=submit_add_bid_form
    Sleep   10
    ${resp}=    Get Text      id=userbidamount
    [Return]    ${resp}

Завантажити документ в ставку
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId
    Click Element           id=edit_user_bid
    Sleep   2
    Capture Page Screenshot
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'bid_doc_upload_fieldcommercialProposal')]   ${ARGUMENTS[1]}
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

Завантажити фінансову ліцензію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  polonex.Завантажити документ в ставку  ${username}  ${filepath}  ${tender_uaid}

Отримати пропозицію
  [Arguments]  ${field}
  Wait Until Page Contains Element    ${locator.proposition.${field}}            30
  Capture Page Screenshot
  ##${proposition_amount}=            Get Value                                    ${locator.proposition.${field}}
  ${proposition_amount}=              Execute Javascript    return $('#userbidamount').html();
  log                                 ${proposition_amount}
  ${proposition_amount}=              Convert To Number                          ${proposition_amount}
  log                                 ${proposition_amount}
  ${data}=     Create Dictionary
  ${bid}=      Create Dictionary
  ${value}=    Create Dictionary
  Set To Dictionary  ${bid}     data=${data}
  Set To Dictionary  ${data}    value=${value}
  Set To Dictionary  ${value}   amount=${proposition_amount}
  [return]           ${bid}

Отримати інформацію із запитання
    [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
    ${index}=   Get Element Attribute   xpath=//td[contains(text(), '${question_id}')]@id
    ${index}=   Get Substring   ${index}    0   4
    ${return_value}=    Get Text     id=${item_id}${field_name}
    [Return]  ${return_value}

Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  ${bid}=   polonex.Отримати пропозицію  ${field}
  [return]  ${bid.data.${field}}

Отримати інформацію про bids
    [Arguments]  @{ARGUMENTS}
    ##Switch Browser       ${ARGUMENTS[0]}

Отримати посилання на аукціон для глядача
    [Arguments]  @{ARGUMENTS}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    ${result}=                  Get Element Attribute               id=show_public_btn@href
    Capture Page Screenshot
    [Return]   ${result}

Отримати посилання на аукціон для учасника
    [Arguments]  @{ARGUMENTS}
    polonex.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    ${result}=                  Get Element Attribute               id=show_private_btn@href
    Capture Page Screenshot
    [Return]   ${result}

Підтвердити постачальника
  [Documentation]
  ...      [Arguments] Username, tender uaid and number of the award to confirm
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  sleep  5
  Click Element     xpath=//a[@id="cwalificate_winer_btn"]
  Wait Until Element Is Visible       id=signed_contract_btn   30

Підтвердити підписання контракту
  [Documentation]
  ...      [Arguments] Username, tender uaid, contract number
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Click Element     xpath=//a[@id="signed_contract_btn"]
  Input Text  xpath=//input[contains(@id,"addsignform-contractnumber")]  12345
  Click Button     id=submit_sign_contract


Скасувати закупівлю
  [Documentation]
  ...      [Arguments] Username, tender uaid, cancellation reason,
  ...      document and new description of document
  ...      [Description] Find tender using uaid, set cancellation reason, get data from cancel_tender
  ...      and call create_cancellation
  ...      After that add document to cancellation and change description of document
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${cancellation_reason}  ${document}  ${new_description}
  polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible       id=cansel_auction_btn   30
  Click Element           id=cansel_auction_btn
  sleep  2
  Input text        xpath=//textarea[@id="canselform-reason"]       ${cancellation_reason}
  Click Element     id=cansel_doc_upload_field
  sleep  2
  Choose File       id=cansel_doc_upload_field                      ${document}
  Wait Until Element Is Visible       xpath=//div[contains(@class, 'ho_upload_item_wrap')]   30
  sleep  4
  Click Element     xpath=//div[contains(@class, 'ho_upload_item_wrap')]/div[contains(@class, 'edit')]
  sleep  2
  Input text        xpath=//textarea[@name="ho_file_info_edit_description"]       ${new_description}
  Click Element           id=fileeditform_submit
  sleep  2
  Click Element           id=submit_cansel_form

Завантажити угоду до тендера
    [Arguments]  ${username}  ${tender_uaid}  ${contract_num}  ${filepath}
    polonex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Capture Page Screenshot

