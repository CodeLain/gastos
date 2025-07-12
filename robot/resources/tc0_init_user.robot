*** Variables ***
${USERNAME}       fede2
${EMAIL}          prueba33@example.com
${PASSWORD}       hola1234

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

   Wait For Elements State    id=nueva_categoria    visible    timeout=10s
    Click With Options               id=nueva_categoria    force=True

    # — Completar y enviar el formulario —
    #Wait Until Element Is Visible    id=id_nombre    timeout=10s
    Wait For Elements State    id=id_nombre    visible    timeout=10s
    Fill Text                        id=id_nombre    TransporteTest
    Click With Options              text="Guardar"   force=True


    ${body}=                  Get Text    css=body
    Should Contain           ${body}      Lista de Gastos