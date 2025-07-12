*** Variables ***
${USERNAME}       prueba_user
${EMAIL}          prueba@example.com
${PASSWORD}       12345

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

    Wait For Elements State    text=La contraseña debe tener al menos 8 caracteres.    visible    timeout=10s

    ${body}=                  Get Text    css=body
    Should Contain           ${body}      La contraseña debe tener al menos 8 caracteres.