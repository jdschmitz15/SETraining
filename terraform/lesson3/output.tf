output "IPlist_Href" {
  value = illumio-core_ip_list.example.href
}

output "IPlist_Name" {
  value = illumio-core_ip_list.example.name
}
output "Service_Href" {
  value = illumio-core_service.example.href
}

output "Service_Name" {
  value = illumio-core_service.example.name
}

output "Label_Href" {
  value = illumio-core_label.example.href
}

output "Label_Name" {
  value = illumio-core_label.example.value
}

// output "Managed_Href" {
//   value = illumio-core_managed_workload.example.href
// }

// output "Managed_Name" {
//   value = illumio-core_managed_workload.example.name
// }
// output "Managed_PublicIP" {
//   value = illumio-core_managed_workload.example.public_ip
// }

output "UMWL_Href" {
  value = illumio-core_unmanaged_workload.example.href
}

output "UMWL_Name" {
  value = illumio-core_unmanaged_workload.example.name
}
output "UMWL_PublicIP" {
  value = illumio-core_unmanaged_workload.example.public_ip
}

