data "template_file" "init" {
  template = "${file("${path.cwd}/setup.sh")}"

  vars {
    ztnetwork   = "[snip]"
    ztapi       = "[snip]"
    slack_webhook_url = "https://hooks.slack.com/services/[whatever]"
  }
}

resource "vcd_vapp" "tf-demo" {
  name		= "tf-demo"
  power_on     	= "false"
  network_name 	= "MyNetwork"
  ip            = "allocated"
  catalog_name  = "MyCatalog"
  template_name = "ubuntu_16.04_small"
  memory        = 4096
  cpus          = 1  
  initscript    = "${data.template_file.init.rendered}"
}
