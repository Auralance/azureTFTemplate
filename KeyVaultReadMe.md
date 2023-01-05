# azureTFTemplate

First, you will need to create a Key Vault and a key in the Key Vault. You can do this using the Azure Portal or by using the Azure CLI.

Next, you will need to grant your Terraform service principal access to the Key Vault. You can do this by using the Azure Portal or by using the Azure CLI.

Then, you can retrieve the key from the Key Vault in your Terraform template by using the azurerm_key_vault_secret resource. Here is an example of how to retrieve a key named "my-key" from a Key Vault named "my-key-vault":

resource "azurerm_key_vault_secret" "my_key" {
  name         = "my-key"
  key_vault_id = azurerm_key_vault.my_key_vault.id
}

You can then reference the key in your other resources by using the azurerm_key_vault_secret.my_key.value attribute. For example, you can use the key as the password for a virtual machine by adding the following to the azurerm_virtual_machine resource:

os_profile {
  computer_name  = var.vm_name
  admin_username = "admin"
  admin_password = azurerm_key_vault_secret.my_key.value
}
