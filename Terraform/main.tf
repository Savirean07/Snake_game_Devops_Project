module "network" {
  source       = "./modules/network"
  project_name = var.project_name
  location     = var.location
  vnet_cidr    = var.vnet_cidr
  subnet_cidr  = var.subnet_cidr
}

module "compute" {
  source          = "./modules/compute"
  project_name    = var.project_name
  location        = var.location
  subnet_id       = module.network.subnet_ids[0]
  instance_size   = var.instance_size
  admin_username  = var.admin_username
  admin_password  = var.admin_password
  instance_count  = var.instance_count
}

resource "azurerm_portal_dashboard" "main" {
  name                = "${var.project_name}-dashboard"
  resource_group_name = module.network.resource_group_name
  location            = var.location

  dashboard_properties = jsonencode({
    lenses = {
      "0" = {
        order = 0
        parts = {
          "0" = {
            position = { x = 0, y = 0, rowSpan = 2, colSpan = 3 }
            metadata = {
              inputs = []
              type   = "Extension/Microsoft_Azure_Monitoring/PartType/MetricsChartPart"
              settings = {
                content = {
                  metrics = [
                    {
                      resourceMetadata = {
                        id = module.compute.vm_ids[0]
                      }
                      name = "Percentage CPU"
                      aggregationType = 4
                    }
                  ]
                }
              }
            }
          }
        }
      }
    }
    metadata = {
      model = {
        timeRange = { value = "PT1H", type = "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange" }
        filterLocale = "en-us"
        filters = {}
        layout = {}
      }
    }
  })
}
