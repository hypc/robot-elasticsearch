Indices Tests
-------------

*** Settings ***
Resource        ../resources.robot
Library         ${LIBRARY_DIR}/indices_apis/IndexLibrary.py  ${SERVER}  ${PORT}  WITH NAME  IndicesIndexLibrary

*** Test Cases ***
查询一个不存在的Indices
    [Tags]                  Indices
    [Timeout]               ${TEST_TIMEOUT}
    Clear Index             customer
    ${resp} =               Get Index  customer
    Status Should be        ${resp}  404
    Validate Json           indices/get_404.schema.json  ${resp.json()}

查询Indices
    [Tags]                  Indices
    [Timeout]               ${TEST_TIMEOUT}
    Clear Index             customer
    Create Index            customer
    ${resp} =               Get Index  customer
    Status Should be        ${resp}  200
    Validate Json           indices/get_200.schema.json  ${resp.json()}
    Clear Index             customer

创建一个Indices
    [Tags]                  Indices
    [Timeout]               ${TEST_TIMEOUT}
    Clear Index             customer
    ${resp} =               Create Index  customer
    Status Should be        ${resp}    200
    Validate Json           indices/create_200.schema.json  ${resp.json()}
    Clear Index             customer

创建一个带参数Indices
    [Tags]                  Indices
    [Timeout]               ${TEST_TIMEOUT}
    Clear Index             customer
    ${resp} =               Create Index  customer  number_of_shards=3  number_of_replicas=2
    Status Should be        ${resp}    200
    Validate Json           indices/create_200.schema.json  ${resp.json()}
    Clear Index             customer

创建一个已存在Indices
    [Tags]                  Indices
    [Timeout]               ${TEST_TIMEOUT}
    Clear Index             customer
    Create Index            customer
    ${resp} =               Create Index  customer
    Status Should be        ${resp}  400
    Validate Json           indices/create_400.schema.json  ${resp.json()}
    Clear Index             customer

*** Keywords ***
Clear Index
    [Arguments]             ${index}
    ${status} =             Check Exists  ${index}
    Run Keyword If          ${status}  Delete Index  ${index}

Check Exists
    [Arguments]             ${index}
    ${resp} =               Head Index  ${index}
    ${status} =             Run Keyword And Return Status  Should Be Equal As Integers  ${resp.status_code}  200
    [Return]                ${status}
