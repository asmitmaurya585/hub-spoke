asmitrg = {
  rg_dev = {
    name     = "rg-dev-eastus"
    location = "East US"
    tags = {
      Environment = "Development"
    }
  }
  rg_prod = {
    name     = "rg-prod-eastus"
    location = "East US"
    tags = {
      Environment = "Production"
    }
  }
}

topology = {
  hub = {
    name           = "rg-hub"
    resource_group = "rg-hub"
    location       = "East US"
    address_space  = ["10.0.0.0/16"]
    subnets = {
      AzureFirewallSubnet = ["10.0.1.0/24"]
      AzureBastionSubnet  = ["10.0.2.0/24"]
      GatewaySubnet       = ["10.0.3.0/24"]
    }
    tags = {
      Role = "Central-Hub"
    }
  }

  spokes = {
    dev = {
      name           = "rg-dev"
      resource_group = "rg-dev"
      location       = "East US"
      address_space  = ["10.1.0.0/16"]
      subnets = {
        web = ["10.1.1.0/24"]
        app = ["10.1.2.0/24"]
      }
      tags = {
        Environment = "Development"
        CostCenter  = "DevOps-101"
      }
    }

    prod = {
      name           = "rg-prod"
      resource_group = "rg-prod"
      location       = "East US"
      address_space  = ["10.2.0.0/16"]
      subnets = {
        web = ["10.2.1.0/24"]
        app = ["10.2.2.0/24"]
        db  = ["10.2.3.0/24"]
      }
      tags = {
        Environment = "Production"
        CostCenter  = "ProdOps-202"
      }
    }
  }
}

tags = {
  Project   = "Azure-Landing-Zone"
  ManagedBy = "Terraform"
}
