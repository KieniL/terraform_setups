vnet_resourcegroup_name = "kali-vnet-rg"
location                = "West Europe"
tags = {
  project = "Kali on Azure"
}
developer_resourcegroup = [
  {
    name         = "LKreidl"
    principal_id = "ec70bbf8-1b41-4a1f-a96e-673fa51053b1"
  },
  {
    name         = "User2"
    principal_id = "311988cb-bac8-4a8b-a0eb-1edbe51f1e83"
  }
]