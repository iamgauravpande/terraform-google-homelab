output "nodepoolname" {
  value = [ for i in google_container_node_pool.workernodepools : i.name ]
}

output "nodepoolversion" {
  value = [ for i in google_container_node_pool.workernodepools : i.version ]
}