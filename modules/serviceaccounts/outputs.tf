output "serviceaccount" {
    value = google_service_account.service_account
}

output "serviceaccount_key" {
    value = [ for i in google_service_account_key.key : i.private_key ]
    sensitive = true
}