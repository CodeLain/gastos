*** Variables ***
${USERNAME}       fede2
${PASSWORD}       hola1234
${GASTO_URL}      http://127.0.0.1:8000/nuevo/

*** Settings ***
Library     Browser
Suite Setup     Open Browser    http://127.0.0.1:8000   chromium
Suite Teardown    Close Browser

*** Test Cases ***
Crear Gasto con campos válidos
    [Documentation]    Usuario crea un gasto completo y se muestra correctamente.
    # Login
    Type Text               id=id_username    ${USERNAME}
    Type Text               id=id_password    ${PASSWORD}
    Click With Options      text=Ingresar        force=True

    # Ir a crear gasto
    Click With Options      text="➕ Nuevo Gasto"    force=True
    # Wait Until Element Is Visible    id=id_monto      timeout=10s
    Wait For Elements State    id=id_monto    visible    timeout=10s

    # Completar campos
    Select Options By       id=id_categoria    label    Transporte
    Type Text               id=id_monto        120.50
    Type Text               id=id_fecha        2025-06-15
    Type Text               id=id_descripcion  Taxi al aeropuerto

    # Enviar
    Click With Options      text="💾 Guardar"     force=True

    # Verificar que se volvió a la lista con nuevo gasto
    #Wait Until Element Is Visible    text=Taxi al aeropuerto     timeout=10s
    Wait For Elements State    text=Taxi al aeropuerto    visible

    # Verificar valores en la fila
    ${body}=                 Get Text               css=table
    Should Contain          ${body}                Taxi al aeropuerto
    Should Contain          ${body}                120.50
    Should Contain          ${body}                July 22, 2025