*** Settings ***
Library     Browser
Suite Setup     Open Browser    http://127.0.0.1:8000/    chromium
Suite Teardown    Close Browser

*** Test Cases ***
Login And See Gastos List
    [Documentation]    Verify valid login and list display using Browser library
    Type Text     id=id_username    fede2
    Type Text     id=id_password    hola1234
    Click         text=Ingresar
    Wait For Elements State    text=Lista de Gastos    visible
    ${page}=    Get Text    css=body
    Should Contain    ${page}    Nuevo Gasto