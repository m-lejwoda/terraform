output "webapp_id" {
    value=values(azurerm_windows_web_app.webapp)[*].id
}

output webapp_hostname {
    value=values(azurerm_windows_web_app.webapp)[*].default_hostname
}