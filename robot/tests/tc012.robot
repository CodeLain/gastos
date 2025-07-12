*** Variables ***
${USERNAME}       fede2
${PASSWORD}       hola1234
${CATEGORY_NAME}  Viajes

*** Settings ***
Library     Browser
Suite Setup     Open Browser    http://127.0.0.1:8000/    chromium
Suite Teardown    Close Browser

*** Test Cases ***
TC‑012 – Crear nueva categoría
    [Documentation]    Verifica que un usuario autenticado puede crear una categoría nueva correctamente.
    # — Login —
    Type Text               id=id_username    ${USERNAME}
    Type Text               id=id_password    ${PASSWORD}
    Click With Options      text=Ingresar       force=True

    # — Abrir formulario de nueva categoría —
    #Wait Until Element Is Visible    text="➕ Nueva categoría"    timeout=10s
    Wait For Elements State    id=nueva_categoria    visible    timeout=10s
    Click With Options               id=nueva_categoria    force=True

    # — Completar y enviar el formulario —
    #Wait Until Element Is Visible    id=id_nombre    timeout=10s
    Wait For Elements State    id=id_nombre    visible    timeout=10s
    Fill Text                        id=id_nombre    ${CATEGORY_NAME}
    Click With Options              text="Guardar"   force=True

    # — Verificar que la categoría aparece en Sidebar o listado —
    #Wait Until Element Is Visible    text=${CATEGORY_NAME}    timeout=10s
    Wait For Elements State    text=Viajes    visible    timeout=10s
    ${page_text}=    Get Text       css=body
    Should Contain   ${page_text}   ${CATEGORY_NAME}