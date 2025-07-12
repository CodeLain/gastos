*** Variables ***
${USERNAME}       gus123
${EMAIL}          gus@mail.com
${PASSWORD}       gus1234!

*** Settings ***
Library     Browser
Suite Setup     Open Browser    http://127.0.0.1:8000/registro/    chromium
Suite Teardown    Close Browser

*** Test Cases ***
Register New User Successfully
    [Documentation]    Automate user registration via the form
    Type Text                 id=id_username     ${USERNAME}
    Type Text                 id=id_email        ${EMAIL}
    Type Text                 id=id_password1    ${PASSWORD}
    Type Text                 id=id_password2    ${PASSWORD}
    Click With Options        text=Registrarse    force=True

    # Verify redirect to gastos list (assuming it redirects there)
    Wait For Elements State    text=Lista de Gastos    visible    timeout=10s

    ${body}=                  Get Text    css=body
    Should Contain           ${body}      Lista de Gastos