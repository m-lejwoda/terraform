variable "resource_group_name" {
   type = string
}

variable "resource_group_location" {
  type = string
}

variable "webapp_environment" {
     type = map(object({
        service_plan_os_type=string
        service_plan_sku=string
        service_plan_location=string
        web_app_name=string
     }
     ))
}

variable "traffic_manager_endpoints" {
     type = map(object({
        priority=number
        weight=number
     }
     ))
}