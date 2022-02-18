allowedSkus = ["Standard_F1s", "Standard_D2s_v3", "Standard_B2s", "Standard_F2s"]
allowedImages = {
  publishers = [
    "Canonical",
    "MicrosoftWindowsServer",
    "fortinet"
  ]
  offers = [
    "0001-com-ubuntu-server-focal",
    "WindowsServer",
    "fortinet_fortiweb-vm_v5"
  ]
  skus = [
    "20_04-lts-gen2",
    "aks-ubuntu-1804-gen2-2022-q1",
    "2019-datacenter-gensecond"
  ]
  versions = [
    "latest",
    "6.3.17"
  ]
}
