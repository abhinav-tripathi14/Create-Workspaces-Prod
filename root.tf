terraform {
  cloud {
    organization = "Test-Abhinav"
    workspaces {
      name = "Create-Workspaces-Prod"
    }
  }
}

module "create-workspace" {
source = "./modules/create-ws"
}
module "create-var-and-varsets"{
source = "./modules/create-var-and-varsets"
}
