provider "vultr" {
  api_key = "43MFXCG2ZD2EUIRD27QIGRW4ZQQOFUXLL6GA"
}

data "vultr_region" "frankfurt" {
  "filter" {
    name   = "name"
    values = ["Frankfurt"]
  }
}

data "vultr_application" "docker" {
  filter {
    name   = "deploy_name"
    values = ["Docker on Ubuntu 18.04 x64"]
  }
}

data "vultr_plan" "starter" {
  filter {
    name   = "price_per_month"
    values = ["5.00"]
  }

  filter {
    name   = "ram"
    values = ["1024"]
  }
}

resource "vultr_startup_script" "strapi_startup_script" {
  name   = "strapi_startup_script"
  script = "${file("startup-script.sh")}"
}

resource "vultr_server" "strapi" {
  region_id = "${data.vultr_region.frankfurt.id}"
  plan_id   = "${data.vultr_plan.starter.id}"
  app_id    = "${data.vultr_application.docker.id}"
  script_id = "${vultr_startup_script.strapi_startup_script.id}"
  hostname  = "strapi"
}
