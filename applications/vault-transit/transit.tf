resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  description               = "KeyStore"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "sym_key" {
  backend          = vault_mount.transit.path
  name             = "sym_key"
  type             = "aes256-gcm96"
  deletion_allowed = true
  exportable       = true
}


resource "vault_transit_secret_backend_key" "asym_key" {
  backend          = vault_mount.transit.path
  name             = "asym_key"
  type             = "rsa-4096"
  deletion_allowed = true
  exportable       = true
}